class Staff::DocumentsController < StaffController
  add_breadcrumb 'document centre', :documents_path

  def index
    load_documents
  end

  def create
    build_document
    save_document
  end

  def destroy
    load_document
    @document.destroy
    redirect_to documents_path
  end

  protected

  def load_documents
    @documents ||= document_scope.to_a
  end

  def load_document
    @document ||= document_scope.find(params[:id])
  end

  def build_document
    @document ||= document_scope.build
    @document.attributes = document_params
  end

  def save_document
    @document.save
  end

  def document_scope
    current_user.documents
  end

  def document_params
    params.require(:document).permit(:direct_upload_url)
  end
end
