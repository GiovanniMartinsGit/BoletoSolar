require "rails_helper"

RSpec.describe TaxasController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(get: "/taxas").to route_to("taxas#index")
    end

    it "routes to #new" do
      expect(get: "/taxas/new").to route_to("taxas#new")
    end

    it "routes to #show" do
      expect(get: "/taxas/1").to route_to("taxas#show", id: "1")
    end

    it "routes to #edit" do
      expect(get: "/taxas/1/edit").to route_to("taxas#edit", id: "1")
    end


    it "routes to #create" do
      expect(post: "/taxas").to route_to("taxas#create")
    end

    it "routes to #update via PUT" do
      expect(put: "/taxas/1").to route_to("taxas#update", id: "1")
    end

    it "routes to #update via PATCH" do
      expect(patch: "/taxas/1").to route_to("taxas#update", id: "1")
    end

    it "routes to #destroy" do
      expect(delete: "/taxas/1").to route_to("taxas#destroy", id: "1")
    end
  end
end
