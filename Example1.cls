public class GuestReviewProcessor {

    @InvocableMethod(
    label='Process Guest Reviews'
    description='Processes guest reviews submitted through Agentforce'
)

    public static List<GuestReviewResponse> processReviews(List<GuestReviewRequest> requests){

        GuestReviewResponse response = new GuestReviewResponse();

        try{

        List<Guest_Review__c> reviewsToInsert = new List<Guest_Review__c>();

        for(GuestReviewRequest req : requests){

            Guest_Review__c reviewRecord = new Guest_Review__c(
                Contact__c = req.contact.Id,
                Experience__c = req.experience.Id,
                Comments__c = req.review,
                Rating__c = req.rating
            );

            reviewsToInsert.add(reviewRecord);
        }

        insert reviewsToInsert;

        response.message = 'Review processed successfully.';

    }
    catch(Exception e){

        response.message = 'There was a problem processing the review.';

    }

        return new List<GuestReviewResponse> { response };

    }

    public class GuestReviewRequest {

    @InvocableVariable(
        required=true
        label='Contact'
        description='Contact submitting the review'
    )
    public Contact contact;

    @InvocableVariable(
        required=true
        label='Experience'
        description='Experience being reviewed'
    )
    public Experience__c experience;

    @InvocableVariable(
        required=true
        label='Review'
        description='Guest review comments'
    )
    public String review;

    @InvocableVariable(
        required=true
        label='Rating'
        description='Guest rating'
    )
    public String rating;
}


    public class GuestReviewResponse {

    @InvocableVariable(
        label='status'
        description='Review processing status'
    )
    public String message;
}

}
 
