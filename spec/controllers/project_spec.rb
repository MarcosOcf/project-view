require 'rails_helper'

describe ProjectsController do

  describe "GET #index" do
    it "should render the index template" do
      get :index
      expect(response).to render_template("index")
    end

    it "should load all of the projects into @projects" do
      project1, project2 = FactoryGirl.create(:project), FactoryGirl.create(:project)
      get :index
      expect(assigns(:projects)).to match([project1, project2])
    end
  end

  describe "GET #new" do
    it "should render the new template" do
      get :new
      expect(response).to render_template("new")  
    end

    it "should create as instance of Project" do
      get :new
      expect(assigns(:project)).to be_a_new(Project)
    end
  end

  describe "POST #create" do
    subject :project do
      post :create, project: FactoryGirl.attributes_for(:project)
    end

    context "with valid attributes" do

      it "creates a new project" do
        expect { 
          post :create, project: FactoryGirl.attributes_for(:project, provider_id: 1) 
        }.to change(Project, :count).by(1)
      end

      it "redirect to show" do    
        subject
        expect(response).to redirect_to assigns(:project)
      end

    end

    context "with invalid attributes" do
      it "does not save the new project" do
        expect {
          post :create, project: FactoryGirl.attributes_for(:invalid_project)
        }.to_not change(Project, :count)
      end

      it "re-renders the new method" do
        post :create, project: FactoryGirl.attributes_for(:invalid_project)
        expect(response).to render_template :new
      end
    end
  end

  describe "DELETE destroy" do

    before :each do
      @project = FactoryGirl.create(:project)
    end

    it "deletes the project" do
      expect{
        delete :destroy, name: @project
      }.to change(Project, :count).by(-1)
    end

    it "redirects to project#index" do
      delete :destroy, name: @project
      expect(response).to redirect_to projects_url
    end
  end

  describe "GET #show" do
    subject :project do
      FactoryGirl.create(:project)
    end

    context "with sucessfull clone" do
      before do
        subject.cloned = true
        subject.can_be_cloned = true
      end
      # it "expect render the #show view" do
      #   # get :show
      #   # expect(response).to render_template :show
      # # end
      # it "expect render the #show_waiting" do
      # end
      # it "expect render the #show_error" do
      # end
    end
  end
end













