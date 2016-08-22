require 'rails_helper'

RSpec.describe ProjectsController, :type => :controller do
  let(:user)  {create(:user)}

  before do
    sign_in user, scope: :user
  end

  describe "#current" do
    it "redirect_to current project show" do
      projects = [create(:project), create(:project), create(:project)]

      post :current, params: { id: projects.first.id }
      
      expect(response).to redirect_to(current_project_path)
      expect(flash[:notice]).to eq "Proyecto #{projects.first.name} seleccionado"
    end
  end

  describe "#destroy" do
    it "redirect_to root path after destroy current project" do
      projects = [create(:project), create(:project), create(:project)]
      user.update(current_project: projects.first)

      delete :destroy, params: { id: projects.first.id }, format: :js
      
      expect(response).to be_ok
      expect(flash[:notice]).to eq 'El proyecto actual ha sido eliminado'
    end
  end
end