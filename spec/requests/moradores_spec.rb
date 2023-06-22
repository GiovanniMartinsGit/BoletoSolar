require 'rails_helper'

# This spec was generated by rspec-rails when you ran the scaffold generator.
# It demonstrates how one might use RSpec to test the controller code that
# was generated by Rails when you ran the scaffold generator.
#
# It assumes that the implementation code is generated by the rails scaffold
# generator. If you are using any extension libraries to generate different
# controller code, this generated spec may or may not pass.
#
# It only uses APIs available in rails and/or rspec-rails. There are a number
# of tools you can use to make these specs even more expressive, but we're
# sticking to rails and rspec-rails APIs to keep things simple and stable.

RSpec.describe "/moradores", type: :request do
  
  # This should return the minimal set of attributes required to create a valid
  # Morador. As you add validations to Morador, be sure to
  # adjust the attributes here as well.
  let(:valid_attributes) {
    skip("Add a hash of attributes valid for your model")
  }

  let(:invalid_attributes) {
    skip("Add a hash of attributes invalid for your model")
  }

  describe "GET /index" do
    it "renders a successful response" do
      Morador.create! valid_attributes
      get moradores_url
      expect(response).to be_successful
    end
  end

  describe "GET /show" do
    it "renders a successful response" do
      morador = Morador.create! valid_attributes
      get morador_url(morador)
      expect(response).to be_successful
    end
  end

  describe "GET /new" do
    it "renders a successful response" do
      get new_morador_url
      expect(response).to be_successful
    end
  end

  describe "GET /edit" do
    it "renders a successful response" do
      morador = Morador.create! valid_attributes
      get edit_morador_url(morador)
      expect(response).to be_successful
    end
  end

  describe "POST /create" do
    context "with valid parameters" do
      it "creates a new Morador" do
        expect {
          post moradores_url, params: { morador: valid_attributes }
        }.to change(Morador, :count).by(1)
      end

      it "redirects to the created morador" do
        post moradores_url, params: { morador: valid_attributes }
        expect(response).to redirect_to(morador_url(Morador.last))
      end
    end

    context "with invalid parameters" do
      it "does not create a new Morador" do
        expect {
          post moradores_url, params: { morador: invalid_attributes }
        }.to change(Morador, :count).by(0)
      end

    
      it "renders a response with 422 status (i.e. to display the 'new' template)" do
        post moradores_url, params: { morador: invalid_attributes }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    
    end
  end

  describe "PATCH /update" do
    context "with valid parameters" do
      let(:new_attributes) {
        skip("Add a hash of attributes valid for your model")
      }

      it "updates the requested morador" do
        morador = Morador.create! valid_attributes
        patch morador_url(morador), params: { morador: new_attributes }
        morador.reload
        skip("Add assertions for updated state")
      end

      it "redirects to the morador" do
        morador = Morador.create! valid_attributes
        patch morador_url(morador), params: { morador: new_attributes }
        morador.reload
        expect(response).to redirect_to(morador_url(morador))
      end
    end

    context "with invalid parameters" do
    
      it "renders a response with 422 status (i.e. to display the 'edit' template)" do
        morador = Morador.create! valid_attributes
        patch morador_url(morador), params: { morador: invalid_attributes }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    
    end
  end

  describe "DELETE /destroy" do
    it "destroys the requested morador" do
      morador = Morador.create! valid_attributes
      expect {
        delete morador_url(morador)
      }.to change(Morador, :count).by(-1)
    end

    it "redirects to the moradores list" do
      morador = Morador.create! valid_attributes
      delete morador_url(morador)
      expect(response).to redirect_to(moradores_url)
    end
  end
end
