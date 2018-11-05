class AgentsController < ApplicationController
  def show
    @agent = Agent.find(params[:id])
    @uploaded_transactions = @agent.all_transactions.paginate(:page => params[:page])
  end

  def random_agent
    redirect_to agent_path(Agent.all.sample)
  end
end
