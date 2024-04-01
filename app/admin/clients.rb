ActiveAdmin.register Client do


  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  # permit_params :name, :address, :company, :phone_number
  #
  # or
  #
  # permit_params do
  #   permitted = [:name, :address, :company, :phone_number]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end

  # permit_params :name, :address, :company, :phone_number

  index title: "All Clients" do
    selectable_column
    id_column
    column :name
    column :address
    column :company
    column :phone_number
    column "Image" do |image|
      
      image_tag(image.image, style: 'width: 100px; height: 100px;') if image.image.attached?
    end
    column 'Download CSV' do |resource|
      link_to 'Download', download_csv_admin_client_path(resource)
    end

    actions
  end

  show title: "Client Details" do
    attributes_table do
      row :name
      row :address
      row :company
      row :phone_number
      row "Image" do |image|
        image_tag(image.image, style: 'width: 100px; height: 100px;') if image.image.attached?
      end 
      
    end
  end

  filter :name
  filter :company

  permit_params :name, :address, :company, :phone_number, :image

  form title: "Client Form" do |f|
    f.inputs "Client" do
      f.input :name
      f.input :address
      f.input :company
      f.input :phone_number
      f.input :image, as: :file
    end
    f.actions
  end

  # Upload CSV_FILE

  action_item :import_csv, only: :index do
    link_to 'Import CSV', action: 'import_csv'
  end
  
  collection_action :import_csv do
    render 'admin/import_csv'
  end
  
  collection_action :process_csv, method: :post do
    # debugger
    csv_file = params[:csv_file].tempfile
    CSV.foreach(csv_file.path, headers: true) do |row|
      Client.create!(row.to_hash)
    end
    redirect_to admin_clients_path, notice: 'CSV imported successfully!'
  end

  # DOWNLOADS CSV_FILE

  member_action :download_csv, method: :get do
    csv_data = CSV.generate(headers: true) do |csv|
     
      csv << ['name', 'address', 'company', 'phone_number'] 
      
      
      csv << [resource.name, resource.address, resource.company, resource.phone_number] 
    end
    
    send_data csv_data, filename: "client_#{resource.id}_data.csv"
  end
end

