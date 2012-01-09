require 'spec_helper'

describe BoothsController do
  describe "#show" do
    let(:state) { mock('MockState', view_name: 'ready') }
    let(:booth) { mock_model(Booth, id: 19, state: state) }

    before do
      Booth.stub(:find).with("19").and_return(booth)
      get :show, id: 19
    end

    it { should assign_to(:booth).with(booth) }
    it { should render_template('ready') }
    it { should render_with_layout }
  end

  describe "#update", "with a commit action" do
    let(:state) { mock('MockState', view_name: 'ready') }
    let(:booth) { mock_model(Booth, id: 19, state: state) }

    before do
      Booth.stub(:find).with("19").and_return(booth)
      booth.should_receive(:update_attributes!).with('mock' => 'attributes').and_return(true)
      state.should_receive(:commit_action)
      booth.should_receive(:save!).and_return(true)
    end

    describe "full request" do
      before do
        post :update, id: 19, booth: { 'mock' => 'attributes' }, commit: 'Commit Action'
      end

      it { should assign_to(:booth).with(booth) }
      it { should render_template('ready') }
      it "should render with a layout" do
        @layouts[nil].should == 0
      end
    end
    
    describe "xhr request" do
      before do
        xhr :post, :update, id: 19, booth: { 'mock' => 'attributes' }, commit: 'Commit Action'
      end

      it { should assign_to(:booth).with(booth) }
      it { should render_template('ready') }
      it "should render with a layout" do
        @layouts[nil].should == 1
      end
    end
  end

  describe "#reset", "when not logged in as poll worker" do
    before do
      post :reset, id: 19
    end

    it { should redirect_to_login }
  end

  describe "#reset", "when logged in as poll worker" do
    let(:booth) { mock_model(Booth) }

    before do
      login_as_election_worker
      Booth.stub(:find).with("19").and_return(booth)
      booth.should_receive(:deactivate!)
      post :reset, id: 19
    end

    it { should redirect_to(root_url) }
  end
end
