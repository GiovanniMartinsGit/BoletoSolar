require "rails_helper"

RSpec.describe LeiturasController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(get: "/leituras").to route_to("leituras#index")
    end

    it "routes to #new" do
      expect(get: "/leituras/new").to route_to("leituras#new")
    end

    it "routes to #show" do
      expect(get: "/leituras/1").to route_to("leituras#show", id: "1")
    end

    it "routes to #edit" do
      expect(get: "/leituras/1/edit").to route_to("leituras#edit", id: "1")
    end


    it "routes to #create" do
      expect(post: "/leituras").to route_to("leituras#create")
    end

    it "routes to #update via PUT" do
      expect(put: "/leituras/1").to route_to("leituras#update", id: "1")
    end

    it "routes to #update via PATCH" do
      expect(patch: "/leituras/1").to route_to("leituras#update", id: "1")
    end

    it "routes to #destroy" do
      expect(delete: "/leituras/1").to route_to("leituras#destroy", id: "1")
    end
  end
end
