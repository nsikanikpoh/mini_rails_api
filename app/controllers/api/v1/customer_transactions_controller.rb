class Api::V1::CustomerTransactionsController < ApplicationController
    before_action :validate_currency, only: :create


   def create
       @transaction = CustomerTransaction.new
       
      
       rate = FxApiService.new("from=#{transaction_params[:currency]}&to=USD").get_rate
       
       logger.info "DDHHD: #{rate.inspect}"
       if rate.is_a? Numeric
            converted_rate = rate * transaction_params[:amount].to_d.round(2)
            @transaction.in_amount = transaction_params[:amount].to_d.round(2)
            @transaction.in_currency = transaction_params[:currency]
            @transaction.out_amount = converted_rate
            @transaction.out_currency = 'USD'
            @transaction.request_ip = request.remote_ip

            @transaction.customer_id = transaction_params[:customer_id]
            @transaction.identifier = SecureRandom.urlsafe_base64
            @transaction.transaction_date = transaction_params[:transaction_date]

            if @transaction.save && @transaction.valid?
                    render json: Api::V1::CustomerTransactionSerializer.new(@transaction).as_json, status: :created
            else
                    render json: {errors: @transaction.errors }, status: :bad_request
            end
        else
            render json: {error: "problem getting rate conversion at the moment please try again later" }, status: 422
        end
   end
  

  
    # GET /posts
    # GET /posts.json
    def index
        @transactions = CustomerTransaction.all.order(created_at: :desc)
        render json: @transactions.map {|transaction| Api::V1::CustomerTransactionSerializer.new(transaction).as_json}, status: :ok
    end
  
    def show
        begin
          @transaction = CustomerTransaction.find(params[:id])
          render json: Api::V1::CustomerTransactionSerializer.new(@transaction).as_json, status: :ok
        rescue => e
            render json: {message: "transation with id: #{params[:id]} not found"}, status: :not_found
        end
    end
  
    private

      def transaction_params
        params.require(:transaction).permit(:amount, :currency, :transaction_date, :customer_id)
      end
  
      def validate_currency
        currencies = CurrencyListLookupService.currencies
       if !currencies.include?(transaction_params[:currency])
          render json: {message: "currency must be in the currency list", currencies: currencies}, status: :bad_request
      end
    end
     
     
  end
  
