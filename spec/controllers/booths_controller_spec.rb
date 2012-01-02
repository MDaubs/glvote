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
  end

  describe "#update", "with a commit action" do
    let(:state) { mock('MockState', view_name: 'ready') }
    let(:booth) { mock_model(Booth, id: 19, state: state) }

    before do
      Booth.stub(:find).with("19").and_return(booth)
      booth.should_receive(:update_attributes!).with('mock' => 'attributes').and_return(true)
      state.should_receive(:commit_action)
      booth.should_receive(:save!).and_return(true)
      post :update, id: 19, booth: { 'mock' => 'attributes' }, commit: 'Commit Action'
    end

    it { should assign_to(:booth).with(booth) }
    it { should render_template('ready') }
  end
end
