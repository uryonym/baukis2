class Admin::AllowedSourcesDeleter
  def delete(params)
    if params && params[:allowed_sources].kind_of?(ActionController::Parameters)
      ids = []

      params[:allowed_sources].values.each do |hash|
        ids << hash[:id] if hash[:_destroy] == '1'
      end

      if ids.present?
        AllowedSource.where(namespace: 'staff', id: ids).delete_all
      end
    end
  end
end
