require 'spec_helper'

describe BoothsController do
  describe "#show", "when inactive" do
    let(:inactive_booth) { mock_model(Booth, id: 19, state: 'inactive') }

    before do
      Booth.stub(:find).with("19").and_return(inactive_booth)
      get :show, id: 19
    end

    it { should assign_to(:booth).with(inactive_booth) }
    it { should render_template('inactive') }
  end

  describe "#show", "when ready" do
    let(:ready_booth) { mock_model(Booth, id: 19, state: 'ready') }

    before do
      Booth.stub(:find).with("19").and_return(ready_booth)
      get :show, id: 19
    end

    it { should assign_to(:booth).with(ready_booth) }
    it { should render_template('ready') }
  end

  describe "#update", "with a commit action" do
    let(:booth) { mock_model(Booth, id: 19, state: 'inactive') }

    before do
      Booth.stub(:find).with("19").and_return(booth)
      booth.should_receive(:update_attributes!).with('mock' => 'attributes').and_return(true)
      booth.should_receive(:commit_action)
      post :update, id: 19, booth: { 'mock' => 'attributes' }, commit: 'Commit Action'
    end

    it { should assign_to(:booth).with(booth) }
    it { should render_template('inactive') }
  end

  describe "#update", "with a flash message from booth" do
    let(:booth) { mock_model(Booth, id: 19, state: 'inactive') }

    before do
      Booth.stub(:find).with("19").and_return(booth)
      booth.should_receive(:update_attributes!).with('mock' => 'attributes').and_return(true)
      booth.should_receive(:return_a_message).and_return('This is a flash message')
      post :update, id: 19, booth: { 'mock' => 'attributes' }, commit: 'Return A Message'
    end

    it { should set_the_flash.to('This is a flash message') }
  end
end
