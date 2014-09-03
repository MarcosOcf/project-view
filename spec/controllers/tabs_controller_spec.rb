require 'rails_helper'

describe TabsController do
  before do
    @project = FactoryGirl.create(:project)
  end

  describe "GET #new" do
    before do
      @tab = FactoryGirl.create(:tab)
      get :new, project_name: @project.name
    end

    it "should render the new template" do  
      expect(response).to render_template("new")
    end

    it "should create as instance of Tab" do
      expect(assigns(:tab)).to be_a_new(Tab)
    end
  end

  describe "POST #create" do

    before do
      tab = FactoryGirl.create(:tab)
    end

    it "create a instance of tab" do
      post :create, tab: FactoryGirl.attributes_for(:tab), project_name: @project.name
      expect(assigns(:tab)).to be_a_new(Tab)
    end
    
    context "if tab doesnt exists" do
      before do
        post :create, tab: FactoryGirl.attributes_for(:tab), project_name: @project.name
      end

      let(:tab_exists) { false }

      it "expect redirects to new path " do
        expect(response).to redirect_to :new_tab
      end
    end

    context "if tab exists" do
      let(:tab_exists) { true }

      before do
        post :create, tab: FactoryGirl.attributes_for(:tab), project_name: @project.name
      end

      it "redirect to 'project' page" do
        expect(response).to redirect_to :new_tab
      end
    end
  end

  describe "DELETE destroy" do
    before do    
      @tab = FactoryGirl.create(:tab, project: :project)
      @project.tabs << @tab
    end

    it "deletes the project" do
      expect{
        delete :destroy, project_name: @project.name, tab_name: @tab.name
      }.to change(Tab, :count).by(-1)
    end

    it "redirects to project" do
      delete :destroy, project_name: @project.name, tab_name: @tab.name
      expect(response).to redirect_to @project
    end
  end
end