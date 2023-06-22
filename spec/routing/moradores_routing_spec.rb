require "rails_helper"

RSpec.describe MoradoresController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(get: "/moradores").to route_to("moradores#index")
    end

    it "routes to #new" do
      expect(get: "/moradores/new").to route_to("moradores#new")
    end

    it "routes to #show" do
      expect(get: "/moradores/1").to route_to("moradores#show", id: "1")
    end

    it "routes to #edit" do
      expect(get: "/moradores/1/edit").to route_to("moradores#edit", id: "1")
    end


    it "routes to #create" do
      expect(post: "/moradores").to route_to("moradores#create")
    end

    it "routes to #update via PUT" do
      expect(put: "/moradores/1").to route_to("moradores#update", id: "1")
    end

    it "routes to #update via PATCH" do
      expect(patch: "/moradores/1").to route_to("moradores#update", id: "1")
    end

    it "routes to #destroy" do
      expect(delete: "/moradores/1").to route_to("moradores#destroy", id: "1")
    end
  end
end
