#!/usr/bin/env ruby
# encoding: UTF-8

require 'google/apis/drive_v3'
require 'googleauth'
require 'googleauth/stores/file_token_store'
require 'fileutils'
require 'yaml'

# Configuration
OOB_URI = 'urn:ietf:wg:oauth:2.0:oob'
APPLICATION_NAME = 'Raouhi Nada Video Uploader'
CREDENTIALS_PATH = 'credentials.json'
TOKEN_PATH = 'token.yaml'
SCOPE = Google::Apis::DriveV3::AUTH_DRIVE_FILE

class DriveUploader
  def initialize
    @service = Google::Apis::DriveV3::DriveService.new
    @service.client_options.application_name = APPLICATION_NAME
    @service.authorization = authorize
  end

  # Autorisation Google OAuth2
  def authorize
    client_id = Google::Auth::ClientId.from_file(CREDENTIALS_PATH)
    token_store = Google::Auth::Stores::FileTokenStore.new(file: TOKEN_PATH)
    authorizer = Google::Auth::UserAuthorizer.new(client_id, SCOPE, token_store)
    user_id = 'default'
    credentials = authorizer.get_credentials(user_id)
    
    if credentials.nil?
      url = authorizer.get_authorization_url(base_url: OOB_URI)
      puts "\n╔═══════════════════════════════════════════════════════════════════╗"
      puts "║  🔐 AUTORISATION GOOGLE DRIVE REQUISE                            ║"
      puts "╚═══════════════════════════════════════════════════════════════════╝\n"
      puts "\n1. Ouvrez cette URL dans votre navigateur :"
      puts "\n   #{url}\n"
      puts "\n2. Autorisez l'application"
      puts "3. Copiez le code d'autorisation"
      puts "4. Collez-le ci-dessous :\n\n"
      print "Code d'autorisation : "
      code = gets.chomp
      credentials = authorizer.get_and_store_credentials_from_code(
        user_id: user_id, code: code, base_url: OOB_URI
      )
    end
    
    credentials
  end

  # Upload d'un fichier vers Google Drive
  def upload_file(file_path, folder_id: nil)
    unless File.exist?(file_path)
      puts "❌ Erreur : Le fichier '#{file_path}' n'existe pas !"
      return nil
    end

    file_name = File.basename(file_path)
    file_size = File.size(file_path)
    file_size_mb = (file_size / 1024.0 / 1024.0).round(2)

    puts "\n╔═══════════════════════════════════════════════════════════════════╗"
    puts "║  📤 UPLOAD VERS GOOGLE DRIVE                                      ║"
    puts "╚═══════════════════════════════════════════════════════════════════╝\n"
    puts "\n📁 Fichier : #{file_name}"
    puts "📊 Taille  : #{file_size_mb} MB"
    puts "\n⏳ Upload en cours...\n\n"

    metadata = {
      name: file_name,
      mime_type: get_mime_type(file_path)
    }
    
    metadata[:parents] = [folder_id] if folder_id

    begin
      file = @service.create_file(
        metadata,
        fields: 'id, name, webViewLink, webContentLink',
        upload_source: file_path,
        content_type: get_mime_type(file_path)
      )

      puts "✅ Upload réussi !\n\n"
      puts "╔═══════════════════════════════════════════════════════════════════╗"
      puts "║  🎉 VIDÉO UPLOADÉE AVEC SUCCÈS !                                 ║"
      puts "╚═══════════════════════════════════════════════════════════════════╝\n"
      puts "\n📋 Informations :"
      puts "   • ID du fichier : #{file.id}"
      puts "   • Nom           : #{file.name}"
      puts "\n🔗 Liens :"
      puts "   • Voir la vidéo : #{file.web_view_link}"
      
      # Rendre le fichier public (optionnel)
      make_public(file.id)
      
      file
    rescue Google::Apis::Error => e
      puts "\n❌ Erreur lors de l'upload : #{e.message}"
      nil
    end
  end

  # Rendre le fichier public
  def make_public(file_id)
    print "\n🌐 Voulez-vous rendre la vidéo publique ? (o/n) : "
    response = gets.chomp.downcase
    
    if response == 'o' || response == 'oui'
      permission = {
        type: 'anyone',
        role: 'reader'
      }
      
      begin
        @service.create_permission(file_id, permission)
        puts "✅ La vidéo est maintenant publique !"
        puts "   Lien de partage : https://drive.google.com/file/d/#{file_id}/view"
      rescue Google::Apis::Error => e
        puts "⚠️  Impossible de rendre le fichier public : #{e.message}"
      end
    end
  end

  # Créer un dossier
  def create_folder(folder_name, parent_id: nil)
    metadata = {
      name: folder_name,
      mime_type: 'application/vnd.google-apps.folder'
    }
    
    metadata[:parents] = [parent_id] if parent_id

    begin
      folder = @service.create_file(metadata, fields: 'id, name')
      puts "✅ Dossier '#{folder_name}' créé avec succès !"
      puts "   ID : #{folder.id}"
      folder
    rescue Google::Apis::Error => e
      puts "❌ Erreur lors de la création du dossier : #{e.message}"
      nil
    end
  end

  # Lister les fichiers
  def list_files(query: nil, max_results: 10)
    begin
      response = @service.list_files(
        q: query,
        page_size: max_results,
        fields: 'files(id, name, mimeType, createdTime, size)'
      )
      
      if response.files.empty?
        puts "Aucun fichier trouvé."
      else
        puts "\n📁 Fichiers sur Google Drive :\n\n"
        response.files.each_with_index do |file, index|
          size = file.size ? "#{(file.size.to_i / 1024.0 / 1024.0).round(2)} MB" : "N/A"
          puts "#{index + 1}. #{file.name} (#{size})"
          puts "   ID: #{file.id}"
        end
      end
      
      response.files
    rescue Google::Apis::Error => e
      puts "❌ Erreur lors de la récupération des fichiers : #{e.message}"
      []
    end
  end

  private

  def get_mime_type(file_path)
    extension = File.extname(file_path).downcase
    mime_types = {
      '.webm' => 'video/webm',
      '.mp4' => 'video/mp4',
      '.avi' => 'video/x-msvideo',
      '.mov' => 'video/quicktime',
      '.mkv' => 'video/x-matroska',
      '.flv' => 'video/x-flv',
      '.wmv' => 'video/x-ms-wmv'
    }
    mime_types[extension] || 'application/octet-stream'
  end
end

# Programme principal
if __FILE__ == $0
  puts "\n╔═══════════════════════════════════════════════════════════════════╗"
  puts "║                                                                   ║"
  puts "║  🎬 UPLOAD VIDÉO VERS GOOGLE DRIVE - RAOUHI NADA 🎬             ║"
  puts "║                                                                   ║"
  puts "╚═══════════════════════════════════════════════════════════════════╝\n"

  # Vérifier si le fichier credentials existe
  unless File.exist?(CREDENTIALS_PATH)
    puts "\n❌ Fichier 'credentials.json' introuvable !"
    puts "\n📖 Pour obtenir ce fichier :"
    puts "   1. Allez sur https://console.cloud.google.com/"
    puts "   2. Créez un projet"
    puts "   3. Activez l'API Google Drive"
    puts "   4. Créez des identifiants OAuth 2.0"
    puts "   5. Téléchargez le fichier JSON"
    puts "   6. Renommez-le en 'credentials.json'"
    puts "   7. Placez-le dans ce dossier\n"
    puts "\n📚 Consultez GUIDE-GOOGLE-DRIVE.md pour plus de détails.\n\n"
    exit 1
  end

  # Initialiser l'uploader
  uploader = DriveUploader.new

  # Menu interactif
  loop do
    puts "\n" + "─" * 70
    puts "\n📋 QUE VOULEZ-VOUS FAIRE ?\n"
    puts "   1. 📤 Uploader une vidéo"
    puts "   2. 📁 Créer un dossier"
    puts "   3. 📋 Lister mes fichiers"
    puts "   4. 🚪 Quitter\n"
    print "\nVotre choix (1-4) : "
    
    choice = gets.chomp

    case choice
    when '1'
      print "\n📁 Chemin du fichier vidéo : "
      file_path = gets.chomp.strip.gsub(/^["']|["']$/, '')
      
      # Chercher le fichier par défaut si aucun chemin n'est fourni
      if file_path.empty?
        default_files = [
          'presentation-raouhi-nada.webm',
          File.join(Dir.home, 'Downloads', 'presentation-raouhi-nada.webm'),
          File.join(Dir.home, 'Téléchargements', 'presentation-raouhi-nada.webm')
        ]
        
        file_path = default_files.find { |f| File.exist?(f) }
        
        if file_path
          puts "✅ Fichier trouvé : #{file_path}"
        else
          puts "❌ Aucun fichier trouvé. Veuillez spécifier le chemin complet."
          next
        end
      end
      
      uploader.upload_file(file_path)
      
    when '2'
      print "\n📁 Nom du dossier : "
      folder_name = gets.chomp
      uploader.create_folder(folder_name)
      
    when '3'
      puts "\n🔍 Recherche de fichiers vidéo..."
      uploader.list_files(query: "mimeType contains 'video/'")
      
    when '4'
      puts "\n👋 Au revoir !\n\n"
      break
      
    else
      puts "\n❌ Choix invalide. Veuillez choisir entre 1 et 4."
    end
  end
end
