#Product Application Demo

# Define api url
$apiBaseUrl = "http://localhost:5009/api/ProductOffer"

do
{

    Write-Host "================================================================================================================="
    write-host "`n"
    Write-Host "Following operation you can perform base on you input"
    Write-Host "1) Get list of product offer"
    Write-Host "2) Get product offer by offer id"
    Write-Host "3) Add a new product offer"
    Write-Host "4) Update existing product offer"
    Write-Host "5) Delete product offer by offer id"
    write-host "`n"
    write-host "========================================================================================================="
    
    $input = Read-Host "Enter action number which you want to perform from above "
    
    write-host "`n"

    try {
    
        switch($input){
        
             1{ 
                    #-------------------------------------------Get List of Prducts Offers--------------------------------------------------------
                    $offer_list_api_endpoint = $apiBaseUrl + "/getofferlist"
                    $offers_list = Invoke-RestMethod -Uri $offer_list_api_endpoint -Method Get -ContentType "application/json"

                    if($offers_list)
                    {
                        foreach($offer in $offers_list) 
                        {
                            Write-Host "Following offers are available"
                            Write-Host $offer
                            write-host "`n"
                        }
                    }
                    else
                    {
                            Write-Host "No product offers available"
                            write-host "`n"
                    } 
              }
                
             2{     #-------------------------------------------Get of Prduct Offer By ID--------------------------------------------------------
                    $input = Read-Host "Enter Offer ID | Ex - 1"
                    write-host "`n"
                    
                    $get_offer_api_endpoint = $apiBaseUrl + "/getofferbyid" +"?Id=$input"
                    
                    $offer = Invoke-RestMethod -Uri $get_offer_api_endpoint -Method Get -ContentType "application/json"

                    if($offer)
                    {
                        Write-Host $offer
                        write-host "`n"
                    }
                    else
                    {
                        Write-Host "Offer id not found"
                        write-host "`n"
                    }    
              }  
                
             3{     #-------------------------------------------Add a new product----------------------------------------------------------------
                    $product_description = @()
                    $product_description = Read-Host = "Enter the offer details | Ex- Samsung Smart TV, 5% off"
                    $product_description = $product_description.Split(",").Trim()
                    
                    $body = @{
                                "id" = 0
                                "productName" = $product_description[0]
                                "offerDescription" = $product_description[1]
                            }| ConvertTo-Json
                    
                    
                    $header = @{
                            "accept" = "application/json"
                            "Content-Type" = "application/json"
                            }
                    
                    $add_offer_api_endpoint = $apiBaseUrl + "/addoffer"
                    
                    $added_offer = Invoke-RestMethod -Uri $add_offer_api_endpoint -Method Post -Body $body -Headers $header
                    
                    if($added_offer)
                    {
                        Write-Host "Below Product Added Successfully"
                        Write-Host $added_offer
                        write-host "`n"
                    }
              }
                
             4{     #-------------------------------------------update product offer ----------------------------------------------------------------
                    $product_description = @()
                    $product_description = Read-Host = "Enter the offer details which you want to update | Ex- 2, Samsung Smart TV, 5% off"
                    $product_description = $product_description.Split(",").Trim()
                    
                    $body = @{
                                "id" = $product_description[0]
                                "productName" = $product_description[1]
                                "offerDescription" = $product_description[2]
                            }| ConvertTo-Json
                    
                    
                    $header = @{
                            "accept" = "application/json"
                            "Content-Type" = "application/json"
                            }
                    
                    $update_offer_api_endpoint = $apiBaseUrl + "/updateoffer"
                    
                    $updated_offer = Invoke-RestMethod -Uri $update_offer_api_endpoint -Method Put -Body $body -Headers $header
                    
                    if($updated_offer)
                    {
                        Write-Host "Below Product Offer Update Successfully"
                        Write-Host $updated_offer
                        write-host "`n"
                    }
              }
              
                
              5{    #-------------------------------------------delete product offer by id----------------------------------------------------------------
                    
                    $input = Read-Host "Enter Offer ID which you want to be delete | Ex- 1"
                    
                    $get_offer_api_endpoint = $apiBaseUrl + "/deleteoffer" +"?Id=$input"
                    
                    $offer = Invoke-RestMethod -Uri $get_offer_api_endpoint -Method Delete -ContentType "application/json"
                    
                    if($offer -eq "True")
                    {
                        Write-Host "Offer deleted successfully"
                        write-host "`n"
                    }
                    else
                    {
                        Write-Host "Offer id not found"
                        write-host "`n"
                    }
              }  

        }#switch
    }#try
    Catch
    {
        Write-OUtput $_.Exception.Message
    }
    $isContinue = Read-Host "Do you want to continue: Y/N"

}Until($isContinue -eq "N")