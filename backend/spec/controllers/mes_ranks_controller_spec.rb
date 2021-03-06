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

RSpec.describe MesRanksController, :type => :controller do
	handle_session
	# This should return the minimal set of attributes required to create a valid
	# MesRank. As you add validations to MesRank, be sure to
	# adjust the attributes here as well.
	let(:mes_level) { FactoryGirl.create :mes_level }
	let(:mes_rank) { FactoryGirl.create :mes_rank, :mes_level_id => mes_level.id }
	let(:valid_attributes) { FactoryGirl.attributes_for :mes_rank, :mes_level_id => mes_level.id }
	let(:invalid_attributes) { FactoryGirl.attributes_for :invalid_mes_rank }

	# This should return the minimal set of values that should be in the session
	# in order to pass any filters (e.g. authentication) defined in
	# MesRanksController. Be sure to keep this updated too.

	describe 'GET index' do
		context 'when authorized' do
			it 'assigns all mes_ranks as @mes_ranks' do
				assign_permission(:read, MesRank)
				mes_rank = MesRank.create! valid_attributes
				get :index, {}
				expect(assigns(:mes_ranks)).to include(mes_rank)
			end
			it 'renders the index template' do
				assign_permission(:read, MesRank)
				get :index
				expect(response).to render_template('index')
			end
		end
		context 'when not authorized' do
			it 'renders unauthorized' do
				revoke_permission(:read, MesRank)
				get :index, {}
				expect(response).to have_http_status(401)
			end
		end
	end


	describe 'GET show' do
		context 'when authorized' do
			it 'assigns the requested mes_rank as @mes_rank' do
				assign_permission(:read, MesRank)
				mes_rank = MesRank.create! valid_attributes
				get :show, {:id => mes_rank.to_param}
				expect(assigns(:mes_rank)).to eq(mes_rank)
			end
		end

		context 'when not authorized' do
			it 'renders unauthorized' do
				revoke_permission(:read, MesRank)
				mes_rank = MesRank.create! valid_attributes
				get :show, {:id => mes_rank.to_param}
				expect(response).to have_http_status(401)
			end
		end

	end

	describe 'GET new' do
		context 'when authorized' do
			it 'assigns a new mes_rank as @mes_rank' do
				assign_permission(:create, MesRank)
				get :new, {}
				expect(assigns(:mes_rank)).to be_a_new(MesRank)
			end
		end

		context 'when not authorized' do
			it 'renders unauthorized' do
				revoke_permission(:create, MesRank)
				get :new, {}
				expect(response).to have_http_status(401)
			end
		end

	end

	describe "GET edit" do
		context 'when authorized' do
			it "assigns the requested mes_rank as @mes_rank" do
				assign_permission(:update, MesRank)
				mes_rank = MesRank.create! valid_attributes
				get :edit, {:id => mes_rank.to_param}
				expect(assigns(:mes_rank)).to eq(mes_rank)
			end
		end

		context 'when not unauthorized' do
			it "renders unauthorized " do
				revoke_permission(:update, MesRank)
				mes_rank = MesRank.create! valid_attributes
				get :edit, {:id => mes_rank.to_param}
				expect(response).to have_http_status(401)
			end
		end
	end

	describe 'POST create' do
		context 'when authorized' do
			before(:each) do
				assign_permission(:create, MesRank)
			end
			describe 'with valid params' do
				it 'creates a new MesRank' do
					expect {
						post :create, {:mes_rank => valid_attributes}
					}.to change(MesRank, :count).by(1)
				end

				it 'assigns a newly created mes_rank as @MesRank' do
					post :create, {:mes_rank => valid_attributes}
					expect(assigns(:mes_rank)).to be_a(MesRank)
				end

				it 'redirects to the created mes_rank' do
					post :create, {:mes_rank => valid_attributes}
					expect(response).to redirect_to(MesRank.last)
				end
			end

			describe 'with invalid params' do
				it 'assigns a newly created but unsaved mes_rank as @mes_rank' do
					post :create, {:mes_rank => invalid_attributes}
					expect(assigns(:mes_rank)).to be_a_new(MesRank)
				end

				it "re-renders the 'new' template" do
					post :create, {:mes_rank => invalid_attributes}
					expect(response).to render_template('new')
				end
			end
		end
		context 'when not unauthorized ' do
			it 'renders unauthorized' do
				revoke_permission(:create, MesRank)
				expect {
					post :create, {:mes_rank => valid_attributes}
				}.to change(MesRank, :count).by(0)
				expect(response).to have_http_status(401)
			end
		end
	end

	describe 'PUT update' do
		let(:new_attributes) { FactoryGirl.attributes_for :mes_rank, :mes_level_id => mes_level.id}

		context 'when authorized' do
			before(:each) do
				assign_permission(:update, MesRank)
			end
			describe 'with valid params' do

				it 'updates the requested mes_rank' do
					mes_rank = MesRank.create! valid_attributes
					put :update, {:id => mes_rank.to_param, :mes_rank => new_attributes}
					mes_rank.reload
					expect(mes_rank.name).to eq(new_attributes[:name])
				end

				it 'assigns the requested mes_rank as @mes_rank' do
					mes_rank = MesRank.create! valid_attributes
					put :update, {:id => mes_rank.to_param, :mes_rank => valid_attributes}
					expect(assigns(:mes_rank)).to eq(mes_rank)
				end

				it 'redirects to the mes_rank' do
					mes_rank = MesRank.create! valid_attributes
					put :update, {:id => mes_rank.to_param, :mes_rank => valid_attributes}
					expect(response).to redirect_to(mes_rank)
				end
			end

			describe 'with invalid params' do
				it 'assigns the mes_rank as @mes_rank' do
					mes_rank = MesRank.create! valid_attributes
					put :update, {:id => mes_rank.to_param, :mes_rank => invalid_attributes}
					expect(assigns(:mes_rank)).to eq(mes_rank)
				end

				it "re-renders the 'edit' template" do
					mes_rank = MesRank.create! valid_attributes
					put :update, {:id => mes_rank.to_param, :mes_rank => invalid_attributes}
					expect(response).to render_template('edit')
				end
			end
		end

		context 'when not unauthorized' do
			it 'renders unauthorized' do
				revoke_permission(:update, MesRank)
				mes_rank = MesRank.create! valid_attributes
				put :update, {:id => mes_rank.to_param, :mes_rank => new_attributes}
				expect(response).to have_http_status(401)
			end
		end
	end

	describe 'DELETE destroy' do
		context 'when authorized' do
			it 'destroys the requested mes_rank' do
				assign_permission(:destroy, MesRank)
				mes_rank = MesRank.create! valid_attributes
				expect {
					delete :destroy, {:id => mes_rank.to_param}
				}.to change(MesRank, :count).by(-1)
			end

			it 'redirects to the mes_ranks list' do
				assign_permission(:destroy, MesRank)
				mes_rank = MesRank.create! valid_attributes
				delete :destroy, {:id => mes_rank.to_param}
				expect(response).to redirect_to(mes_ranks_url)
			end
		end
		context 'when not unauthorized' do
			it 'renders unauthorized' do
				revoke_permission(:destroy, MesRank)
				mes_rank = MesRank.create! valid_attributes
				expect {
					delete :destroy, {:id => mes_rank.to_param}
				}.to change(MesRank, :count).by(0)
				expect(response).to have_http_status(401)
			end
		end
	end
end
