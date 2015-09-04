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

RSpec.describe ArmyRanksController, :type => :controller do
  handle_session
  # This should return the minimal set of attributes required to create a valid
  # ArmyRank. As you add validations to ArmyRank, be sure to
  # adjust the attributes here as well.
  let(:military_level) { FactoryGirl.create :military_level }
  let(:army_rank) { FactoryGirl.create :army_rank, :military_level_id => military_level.id }
  let(:valid_attributes) { FactoryGirl.attributes_for :army_rank, :military_level_id => military_level.id}
  let(:invalid_attributes) { FactoryGirl.attributes_for :invalid_army_rank}

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # ArmyRanksController. Be sure to keep this updated too.

  describe 'GET index' do
    context 'when authorized' do
      it 'assigns all army_ranks as @army_ranks' do
        assign_permission(:read, ArmyRank)
        army_rank = ArmyRank.create! valid_attributes
        get :index, {}
        expect(assigns(:army_ranks)).to include(army_rank)
      end
      it 'renders the index template' do
        assign_permission(:read, ArmyRank)
        get :index
        expect(response).to render_template('index')
      end
    end
    context 'when not authorized' do
      it 'renders unauthorized' do
        revoke_permission(:read, ArmyRank)
        get :index, {}
        expect(response).to have_http_status(401)
      end
    end
  end


  describe 'GET show' do
    context 'when authorized' do
      it 'assigns the requested army_rank as @army_rank' do
        assign_permission(:read, ArmyRank)
        army_rank = ArmyRank.create! valid_attributes
        get :show, {:id => army_rank.to_param}
        expect(assigns(:army_rank)).to eq(army_rank)
      end
    end

    context 'when not authorized' do
      it 'renders unauthorized' do
        revoke_permission(:read, ArmyRank)
        army_rank = ArmyRank.create! valid_attributes
        get :show, {:id => army_rank.to_param}
        expect(response).to have_http_status(401)
      end
    end

  end

  describe 'GET new' do
    context 'when authorized' do
      it 'assigns a new army_rank as @army_rank' do
        assign_permission(:create, ArmyRank)
        get :new, {}
        expect(assigns(:army_rank)).to be_a_new(ArmyRank)
      end
    end

    context 'when not authorized' do
      it 'renders unauthorized' do
        revoke_permission(:create, ArmyRank)
        get :new, {}
        expect(response).to have_http_status(401)
      end
    end

  end

  describe "GET edit" do
    context 'when authorized' do
      it "assigns the requested army_rank as @army_rank" do
        assign_permission(:update, ArmyRank)
        army_rank = ArmyRank.create! valid_attributes
        get :edit, {:id => army_rank.to_param}
        expect(assigns(:army_rank)).to eq(army_rank)
      end
    end

    context 'when not unauthorized' do
      it "renders unauthorized " do
        revoke_permission(:update, ArmyRank)
        army_rank = ArmyRank.create! valid_attributes
        get :edit, {:id => army_rank.to_param}
        expect(response).to have_http_status(401)
      end
    end
  end

  describe 'POST create' do
    context 'when authorized' do
      before(:each) do
        assign_permission(:create, ArmyRank)
      end
      describe 'with valid params' do
        it 'creates a new ArmyRank' do
          expect {
            post :create, {:army_rank => valid_attributes}
          }.to change(ArmyRank, :count).by(1)
        end

        it 'assigns a newly created army_rank as @ArmyRank' do
          post :create, {:army_rank => valid_attributes}
          expect(assigns(:army_rank)).to be_a(ArmyRank)
        end

        it 'redirects to the created army_rank' do
          post :create, {:army_rank => valid_attributes}
          expect(response).to redirect_to(ArmyRank.last)
        end
      end

      describe 'with invalid params' do
        it 'assigns a newly created but unsaved army_rank as @army_rank' do
          post :create, {:army_rank => invalid_attributes}
          expect(assigns(:army_rank)).to be_a_new(ArmyRank)
        end

        it "re-renders the 'new' template" do
          post :create, {:army_rank => invalid_attributes}
          expect(response).to render_template('new')
        end
      end
    end
    context 'when not unauthorized ' do
      it 'renders unauthorized' do
        revoke_permission(:create, ArmyRank)
        expect {
          post :create, {:army_rank => valid_attributes}
        }.to change(ArmyRank, :count).by(0)
        expect(response).to have_http_status(401)
      end
    end
  end

  describe 'PUT update' do
    let(:new_attributes) { FactoryGirl.attributes_for :army_rank, :military_level_id => military_level.id}

    context 'when authorized' do
      before(:each) do
        assign_permission(:update, ArmyRank)
      end
      describe 'with valid params' do

        it 'updates the requested army_rank' do
          army_rank = ArmyRank.create! valid_attributes
          put :update, {:id => army_rank.to_param, :army_rank => new_attributes}
          army_rank.reload
          expect(army_rank.name).to eq(new_attributes[:name])
        end

        it 'assigns the requested army_rank as @army_rank' do
          army_rank = ArmyRank.create! valid_attributes
          put :update, {:id => army_rank.to_param, :army_rank => valid_attributes}
          expect(assigns(:army_rank)).to eq(army_rank)
        end

        it 'redirects to the army_rank' do
          army_rank = ArmyRank.create! valid_attributes
          put :update, {:id => army_rank.to_param, :army_rank => valid_attributes}
          expect(response).to redirect_to(army_rank)
        end
      end

      describe 'with invalid params' do
        it 'assigns the army_rank as @army_rank' do
          army_rank = ArmyRank.create! valid_attributes
          put :update, {:id => army_rank.to_param, :army_rank => invalid_attributes}
          expect(assigns(:army_rank)).to eq(army_rank)
        end

        it "re-renders the 'edit' template" do
          army_rank = ArmyRank.create! valid_attributes
          put :update, {:id => army_rank.to_param, :army_rank => invalid_attributes}
          expect(response).to render_template('edit')
        end
      end
    end

    context 'when not unauthorized' do
      it 'renders unauthorized' do
        revoke_permission(:update, ArmyRank)
        army_rank = ArmyRank.create! valid_attributes
        put :update, {:id => army_rank.to_param, :army_rank => new_attributes}
        expect(response).to have_http_status(401)
      end
    end
  end

  describe 'DELETE destroy' do
    context 'when authorized' do
      it 'destroys the requested army_rank' do
        assign_permission(:destroy, ArmyRank)
        army_rank = ArmyRank.create! valid_attributes
        expect {
          delete :destroy, {:id => army_rank.to_param}
        }.to change(ArmyRank, :count).by(-1)
      end

      it 'redirects to the army_ranks list' do
        assign_permission(:destroy, ArmyRank)
        army_rank = ArmyRank.create! valid_attributes
        delete :destroy, {:id => army_rank.to_param}
        expect(response).to redirect_to(army_ranks_url)
      end
    end
    context 'when not unauthorized' do
      it 'renders unauthorized' do
        revoke_permission(:destroy, ArmyRank)
        army_rank = ArmyRank.create! valid_attributes
        expect {
          delete :destroy, {:id => army_rank.to_param}
        }.to change(ArmyRank, :count).by(0)
        expect(response).to have_http_status(401)
      end
    end
  end
end
