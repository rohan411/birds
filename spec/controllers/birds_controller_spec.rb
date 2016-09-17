
RSpec.describe BirdsController, :type => :controller do
  let (:bird) {FactoryGirl.create(:bird)}

  context 'create a bird :' do

    it "should check for incomplete params" do
      @request.env["HTTP_ACCEPT"] = "application/json"
      @request.env["CONTENT_TYPE"] = "multipart/form-data"
      post :create, {
                      name: "Pigeon",
                      family: "Birds"
                    }
      response_body = JSON.parse(response.body)
      expect(response.status).to eq(400)
      expect(response_body["meta"]["success"]).to eq(false)
    end

    it "should create a bird with default values" do
      @request.env["HTTP_ACCEPT"] = "application/json"
      @request.env["CONTENT_TYPE"] = "multipart/form-data"
      post :create, {
                      name: "Pigeon",
                      family: "Birds",
                      continents: ["Asia"]
                    }
      response_body = JSON.parse(response.body)
      expect(response.status).to eq(201)
      expect(Bird.count).to eq(1)
      expect(response_body["added"]).to eq(Time.now.utc.strftime("%F"))
    end

    it "should create a bird without default values" do
      @request.env["HTTP_ACCEPT"] = "application/json"
      @request.env["CONTENT_TYPE"] = "multipart/form-data"
      date = "2016-09-09"
      post :create, {
                      name: "Pigeon",
                      family: "Birds",
                      continents: ["Asia"],
                      visible: true,
                      added: date
                    }
      response_body = JSON.parse(response.body)
      expect(response.status).to eq(201)
      expect(response_body["added"]).to eq(date)
    end
  end

  it "should fetch all the visible birds" do
    @request.env["HTTP_ACCEPT"] = "application/json"
    @request.env["CONTENT_TYPE"] = "multipart/form-data"
    bird
    get :index
    response_body = JSON.parse(response.body)
    expect(response.status).to eq(200)
    expect(response_body.first["id"]).to eq(bird.id.to_s)
  end

  context 'fetch a bird :' do

    it "should return not found error in case of unavailable id" do
      @request.env["HTTP_ACCEPT"] = "application/json"
      @request.env["CONTENT_TYPE"] = "multipart/form-data"
      get :show, {
                      id: 123
                  }
      response_body = JSON.parse(response.body)
      expect(response.status).to eq(404)
      expect(response_body["meta"]["success"]).to eq(false)
    end

    it "should return a bird with available id" do
      @request.env["HTTP_ACCEPT"] = "application/json"
      @request.env["CONTENT_TYPE"] = "multipart/form-data"
      get :show, {
                      id: bird.id
                  }
      response_body = JSON.parse(response.body)
      expect(response.status).to eq(200)
      expect(response_body["id"]).to eq(bird.id.to_s)
    end
  end

  context 'delete a bird :' do

    it "should return not found error in case of unavailable id" do
      @request.env["HTTP_ACCEPT"] = "application/json"
      @request.env["CONTENT_TYPE"] = "multipart/form-data"
      delete :destroy, {
                          id: 123
                        }
      response_body = JSON.parse(response.body)
      expect(response.status).to eq(404)
      expect(response_body["meta"]["success"]).to eq(false)
    end

    it "should delete a bird with available id" do
      @request.env["HTTP_ACCEPT"] = "application/json"
      @request.env["CONTENT_TYPE"] = "multipart/form-data"
      delete :destroy, {
                          id: bird.id
                        }
      response_body = JSON.parse(response.body)
      expect(response.status).to eq(200)
      expect(Bird.count).to eq(0)
    end
  end

end
