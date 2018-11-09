class UploadedTransactionsController < ApplicationController
  def new
    @agent = Agent.find(params[:agent_id])
    @uploaded_transaction = @agent.all_transactions.new
  end

  def create
    agent = Agent.find(params[:agent_id])
    updated_params = uploaded_transaction_params

    if params.key?('selling_agent_id') && params.key?('listing_agent_id')
      updated_params['selling_agent_id'] = params[:agent_id]
      updated_params['listing_agent_id'] = params[:agent_id]
    elsif !params.key?('selling_agent_id') && params.key?('listing_agent_id')
      updated_params['listing_agent_id'] = params[:agent_id]
    else
      updated_params['selling_agent_id'] = params[:agent_id]
    end

    uploaded_transaction = agent.all_transactions.create(updated_params)

    if uploaded_transaction.save
      redirect_to agent_path(agent), notice: "Transaction saved!"
    else
      render "new"
    end
  end

  def import
    UploadedTransaction.import(params[:file])
    redirect_to root_url, notice: "CSV imported!"
  end
  private

  def uploaded_transaction_params
    params.require(:uploaded_transaction).permit(:address, :city, :state, :zip, :listing_agent, :listing_price, :listing_date, :selling_price, :selling_agent, :selling_date, :status, :property_type)
  end
end
