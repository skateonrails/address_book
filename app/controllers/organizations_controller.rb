class OrganizationsController < TokenAuthenticatableController
  before_action :user_is_admin?

  # GET /organizations
  def index
    render json: organizations
  end

  # GET /organizations/1
  def show
    render json: organization
  end

  # POST /organizations
  def create
    new_organization.save!
    render json: new_organization, status: :created, location: new_organization
  end

  # PATCH/PUT /organizations/1
  def update
    organization.update!(organization_params)
    render json: organization
  end

  # DELETE /organizations/1
  def destroy
    organization.destroy
  end

  private

  def organizations
    @organizations ||= Organization.all
  end

  def organization
    @organization ||= Organization.find(params[:id])
  end

  def new_organization
    @organization ||= Organization.new(organization_params)
  end

  def organization_params
    params.require(:organization).permit(:name)
  end

  def user_is_admin?
    render json: { error: 'Not Authorized' }, status: 401 unless @current_user.is_admin?
  end
end
