require 'rails_helper'

# This spec was generated by rspec-rails when you ran the scaffold generator.
# It demonstrates how one might use RSpec to specify the controller code that
# was generated by Rails when you ran the scaffold generator.
#
# It assumes that the implementation code is generated by the rails scaffold
# generator.  If you are using any extension libraries to generate different
# controller code, this generated spec may or may not pass.
#
# It only uses APIs available in rails and/or rspec-rails.  There are a number
# of tools you can use to make these specs even more expressive, but we're
# sticking to rails and rspec-rails APIs to keep things simple and stable.
#
# Compared to earlier versions of this generator, there is very limited use of
# stubs and message expectations in this spec.  Stubs are only used when there
# is no simpler way to get a handle on the object needed for the example.
# Message expectations are only used when there is no simpler way to specify
# that an instance is receiving a specific message.

RSpec.describe CountriesController, :type => :controller do
  handle_session
  # This should return the minimal set of attributes required to create a valid
  # Country. As you add validations to Country, be sure to
  # adjust the attributes here as well.
  let(:country) { FactoryGirl.create :country }
  let(:valid_attributes) { FactoryGirl.attributes_for :country}
  let(:invalid_attributes) { FactoryGirl.attributes_for :invalid_country}

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # CountriesController. Be sure to keep this updated too.

  describe 'GET index' do
    context 'when authorized' do
      it 'assigns all countries as @countries' do
        assign_permission(:read, Country)
        country = Country.create! valid_attributes
        get :index, {}
        expect(assigns(:countries)).to include(country)
      end
      it 'renders the index template' do
        assign_permission(:read, Country)
        get :index
        expect(response).to render_template('index')
      end
    end
    context 'when not authorized' do
      it 'renders unauthorized' do
        revoke_permission(:read, Country)
        get :index, {}
        expect(response).to have_http_status(401)
      end
    end
  end


  describe 'GET show' do
    context 'when authorized' do
      it 'assigns the requested country as @country' do
        assign_permission(:read, Country)
        country = Country.create! valid_attributes
        get :show, {:id => country.to_param}
        expect(assigns(:country)).to eq(country)
      end
    end

    context 'when not authorized' do
      it 'renders unauthorized' do
        revoke_permission(:read, Country)
        country = Country.create! valid_attributes
        get :show, {:id => country.to_param}
        expect(response).to have_http_status(401)
      end
    end

  end

  describe 'GET new' do
    context 'when authorized' do
      it 'assigns a new country as @country' do
        assign_permission(:create, Country)
        get :new, {}
        expect(assigns(:country)).to be_a_new(Country)
      end
    end

    context 'when not authorized' do
      it 'renders unauthorized' do
        revoke_permission(:create, Country)
        get :new, {}
        expect(response).to have_http_status(401)
      end
    end

  end

  describe "GET edit" do
    context 'when authorized' do
      it "assigns the requested country as @country" do
        assign_permission(:update, Country)
        country = Country.create! valid_attributes
        get :edit, {:id => country.to_param}
        expect(assigns(:country)).to eq(country)
      end
    end

    context 'when not unauthorized' do
      it "renders unauthorized " do
        revoke_permission(:update, Country)
        country = Country.create! valid_attributes
        get :edit, {:id => country.to_param}
        expect(response).to have_http_status(401)
      end
    end
  end

  describe 'POST create' do
    context 'when authorized' do
      before(:each) do
        assign_permission(:create, Country)
      end
      describe 'with valid params' do
        it 'creates a new Country' do
          expect {
            post :create, {:country => valid_attributes}
          }.to change(Country, :count).by(1)
        end

        it 'assigns a newly created country as @Country' do
          post :create, {:country => valid_attributes}
          expect(assigns(:country)).to be_a(Country)
        end

        it 'redirects to the created country' do
          post :create, {:country => valid_attributes}
          expect(response).to redirect_to(Country.last)
        end
      end

      describe 'with invalid params' do
        it 'assigns a newly created but unsaved country as @country' do
          post :create, {:country => invalid_attributes}
          expect(assigns(:country)).to be_a_new(Country)
        end

        it "re-renders the 'new' template" do
          post :create, {:country => invalid_attributes}
          expect(response).to render_template('new')
        end
      end
    end
    context 'when not unauthorized ' do
      it 'renders unauthorized' do
        revoke_permission(:create, Country)
        expect {
          post :create, {:country => valid_attributes}
        }.to change(Country, :count).by(0)
        expect(response).to have_http_status(401)
      end
    end
  end

  describe 'PUT update' do
    let(:new_attributes) { FactoryGirl.attributes_for :country}

    context 'when authorized' do
      before(:each) do
        assign_permission(:update, Country)
      end
      describe 'with valid params' do

        it 'updates the requested country' do
          country = Country.create! valid_attributes
          put :update, {:id => country.to_param, :country => new_attributes}
          country.reload
          expect(country.name).to eq(new_attributes[:name])
        end

        it 'assigns the requested country as @country' do
          country = Country.create! valid_attributes
          put :update, {:id => country.to_param, :country => valid_attributes}
          expect(assigns(:country)).to eq(country)
        end

        it 'redirects to the country' do
          country = Country.create! valid_attributes
          put :update, {:id => country.to_param, :country => valid_attributes}
          expect(response).to redirect_to(country)
        end
      end

      describe 'with invalid params' do
        it 'assigns the country as @country' do
          country = Country.create! valid_attributes
          put :update, {:id => country.to_param, :country => invalid_attributes}
          expect(assigns(:country)).to eq(country)
        end

        it "re-renders the 'edit' template" do
          country = Country.create! valid_attributes
          put :update, {:id => country.to_param, :country => invalid_attributes}
          expect(response).to render_template('edit')
        end
      end
    end

    context 'when not unauthorized' do
      it 'renders unauthorized' do
        revoke_permission(:update, Country)
        country = Country.create! valid_attributes
        put :update, {:id => country.to_param, :country => new_attributes}
        expect(response).to have_http_status(401)
      end
    end
  end

  describe 'DELETE destroy' do
    context 'when authorized' do
      it 'destroys the requested country' do
        assign_permission(:destroy, Country)
        country = Country.create! valid_attributes
        expect {
          delete :destroy, {:id => country.to_param}
        }.to change(Country, :count).by(-1)
      end

      it 'redirects to the countries list' do
        assign_permission(:destroy, Country)
        country = Country.create! valid_attributes
        delete :destroy, {:id => country.to_param}
        expect(response).to redirect_to(countries_url)
      end
    end
    context 'when not unauthorized' do
      it 'renders unauthorized' do
        revoke_permission(:destroy, Country)
        country = Country.create! valid_attributes
        expect {
          delete :destroy, {:id => country.to_param}
        }.to change(Country, :count).by(0)
        expect(response).to have_http_status(401)
      end
    end
  end
end
