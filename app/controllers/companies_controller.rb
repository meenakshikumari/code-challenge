class CompaniesController < ApplicationController
  before_action :set_company, except: [:index, :create, :new]

  def index
    @companies = Company.all
  end

  def new
    @company = Company.new
  end

  def show
  end

  def create
    @company = Company.new(company_params)
    if @company.save
      redirect_to companies_path, notice: t('saved')
    else
      display_error
      render :new
    end
  end

  def edit
  end

  def update
    if @company.update(company_params)
      redirect_to company_path(@company), notice: t('changes_saved') #after update user should be able to see the changes made
    else
      display_error
      render :edit
    end
  end

  def destroy
    # we can also add some restriction for who can delete on basis of owner_id (eg; system admin )
    if @company.destroy
      redirect_to companies_path, notice: t('company_deleted_successfully')
    else
      display_error
      redirect_to company_path(@company)
    end
  end

  private

  def display_error
    flash[:error] = "#{@company.errors.full_messages.join(', ')}"
  end

  def company_params
    params.require(:company).permit(
      :name,
      :legal_name,
      :description,
      :zip_code,
      :phone,
      :email,
      :owner_id,
    )
  end

  def set_company
    @company = Company.find(params[:id])
  end
  
end
