require "rails_helper"

RSpec.describe ImoveisController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(get: "/imoveis").to route_to("imoveis#index")
    end

    it "routes to #new" do
      expect(get: "/imoveis/new").to route_to("imoveis#new")
    end

    it "routes to #show" do
      expect(get: "/imoveis/1").to route_to("imoveis#show", id: "1")
    end

    it "routes to #edit" do
      expect(get: "/imoveis/1/edit").to route_to("imoveis#edit", id: "1")
    end


    it "routes to #create" do
      expect(post: "/imoveis").to route_to("imoveis#create")
    end

    it "routes to #update via PUT" do
      expect(put: "/imoveis/1").to route_to("imoveis#update", id: "1")
    end

    it "routes to #update via PATCH" do
      expect(patch: "/imoveis/1").to route_to("imoveis#update", id: "1")
    end

    it "routes to #destroy" do
      expect(delete: "/imoveis/1").to route_to("imoveis#destroy", id: "1")
    end
  end
end
