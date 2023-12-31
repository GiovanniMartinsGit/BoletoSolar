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

RSpec.describe "/taxas", type: :request do
  
  # This should return the minimal set of attributes required to create a valid
  # Taxa. As you add validations to Taxa, be sure to
  # adjust the attributes here as well.
  let(:valid_attributes) {
    skip("Add a hash of attributes valid for your model")
  }

  let(:invalid_attributes) {
    skip("Add a hash of attributes invalid for your model")
  }

  describe "GET /index" do
    it "renders a successful response" do
      Taxa.create! valid_attributes
      get taxas_url
      expect(response).to be_successful
    end
  end

  describe "GET /show" do
    it "renders a successful response" do
      taxa = Taxa.create! valid_attributes
      get taxa_url(taxa)
      expect(response).to be_successful
    end
  end

  describe "GET /new" do
    it "renders a successful response" do
      get new_taxa_url
      expect(response).to be_successful
    end
  end

  describe "GET /edit" do
    it "renders a successful response" do
      taxa = Taxa.create! valid_attributes
      get edit_taxa_url(taxa)
      expect(response).to be_successful
    end
  end

  describe "POST /create" do
    context "with valid parameters" do
      it "creates a new Taxa" do
        expect {
          post taxas_url, params: { taxa: valid_attributes }
        }.to change(Taxa, :count).by(1)
      end

      it "redirects to the created taxa" do
        post taxas_url, params: { taxa: valid_attributes }
        expect(response).to redirect_to(taxa_url(Taxa.last))
      end
    end

    context "with invalid parameters" do
      it "does not create a new Taxa" do
        expect {
          post taxas_url, params: { taxa: invalid_attributes }
        }.to change(Taxa, :count).by(0)
      end

    
      it "renders a response with 422 status (i.e. to display the 'new' template)" do
        post taxas_url, params: { taxa: invalid_attributes }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    
    end
  end

  describe "PATCH /update" do
    context "with valid parameters" do
      let(:new_attributes) {
        skip("Add a hash of attributes valid for your model")
      }

      it "updates the requested taxa" do
        taxa = Taxa.create! valid_attributes
        patch taxa_url(taxa), params: { taxa: new_attributes }
        taxa.reload
        skip("Add assertions for updated state")
      end

      it "redirects to the taxa" do
        taxa = Taxa.create! valid_attributes
        patch taxa_url(taxa), params: { taxa: new_attributes }
        taxa.reload
        expect(response).to redirect_to(taxa_url(taxa))
      end
    end

    context "with invalid parameters" do
    
      it "renders a response with 422 status (i.e. to display the 'edit' template)" do
        taxa = Taxa.create! valid_attributes
        patch taxa_url(taxa), params: { taxa: invalid_attributes }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    
    end
  end

  describe "DELETE /destroy" do
    it "destroys the requested taxa" do
      taxa = Taxa.create! valid_attributes
      expect {
        delete taxa_url(taxa)
      }.to change(Taxa, :count).by(-1)
    end

    it "redirects to the taxas list" do
      taxa = Taxa.create! valid_attributes
      delete taxa_url(taxa)
      expect(response).to redirect_to(taxas_url)
    end
  end
end
