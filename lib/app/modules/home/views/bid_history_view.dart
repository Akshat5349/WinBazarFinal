import 'package:azmatka/app/modules/home/controllers/bid_history_controller.dart';
import 'package:azmatka/constants/values.dart';

class BidHistoryView extends GetView<BidHistoryController> {
  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => BidHistoryController());

    return Scaffold(
        backgroundColor: Color(0xFFF8F9FA),
        appBar: AppBar(
          title: Text(
            'Bid History',
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          centerTitle: false,
          backgroundColor: AppColors.primaryColor,
          elevation: 0,
          iconTheme: IconThemeData(color: Colors.white),
        ),
        body: Obx(
          () => controller.loading.value
              ? Center(
                  child: CircularProgressIndicator(
                    valueColor:
                        AlwaysStoppedAnimation<Color>(AppColors.primaryColor),
                  ),
                )
              : controller.historyData.length == 0
                  ? _buildEmptyState()
                  : Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      child: ListView.builder(
                        itemCount: controller.historyData.length,
                        itemBuilder: (context, index) {
                          var item = controller.historyData[index];
                          return _buildModernBidCard(item, index);
                        },
                      ),
                    ),
        ));
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.history_outlined,
            size: 80,
            color: Colors.grey[400],
          ),
          SizedBox(height: 16),
          Text(
            'No Bid History',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.grey[600],
            ),
          ),
          SizedBox(height: 8),
          Text(
            'Your betting history will appear here',
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey[500],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildModernBidCard(Map item, int index) {
    // Get market name
    String marketName = item.containsKey('starline_market_id')
        ? item['starline_market_id']['market_name']
        : item.containsKey('mumbai_market_id')
            ? item['mumbai_market_id']['market_name']
            : item.containsKey('delhi_market_id')
                ? item['delhi_market_id']['market_name']
                : item['market_id']['market_name'];

    // Get game type
    String gameType =
        item.containsKey('game_type_id') && item['game_type_id'] != null
            ? item['game_type_id']['type'].toString()
            : 'Single';

    // Get game order
    int gameOrder =
        item.containsKey('game_type_id') && item['game_type_id'] != null
            ? int.tryParse(item['game_type_id']['order'].toString()) ?? 0
            : 0;

    // Determine number display based on order and session
    String displayNumber = _getDisplayNumber(item, gameOrder);

    // Get session with proper formatting
    String session = item['session'].toString().toUpperCase();

    // Determine status color
    Color statusColor = _getStatusColor(session);

    return Container(
      margin: EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 12,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Container(
          decoration: BoxDecoration(
            border: Border(
              left: BorderSide(
                color: statusColor,
                width: 4,
              ),
            ),
          ),
          child: Padding(
            padding: EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header row with market name and session
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        marketName,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: AppColors.primaryColor,
                        ),
                      ),
                    ),
                    Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: statusColor.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: statusColor,
                          width: 1,
                        ),
                      ),
                      child: Text(
                        session,
                        style: TextStyle(
                          color: statusColor,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 16),

                // Game type and number row
                Row(
                  children: [
                    Expanded(
                      child: _buildInfoTile(
                        icon: Icons.games_outlined,
                        title: 'Game Type',
                        value: gameType,
                        color: Color(0xFF6C5CE7),
                      ),
                    ),
                    SizedBox(width: 12),
                    Expanded(
                      child: _buildInfoTile(
                        icon: Icons.confirmation_number_outlined,
                        title: 'Number',
                        value: displayNumber,
                        color: Color(0xFFE17055),
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 12),

                // Date and amount row
                Row(
                  children: [
                    Expanded(
                      child: _buildInfoTile(
                        icon: Icons.calendar_today_outlined,
                        title: 'Date',
                        value: item['date'].toString(),
                        color: Color(0xFF00B894),
                      ),
                    ),
                    SizedBox(width: 12),
                    Expanded(
                      child: _buildInfoTile(
                        icon: Icons.currency_rupee_outlined,
                        title: 'Amount',
                        value: '₹${item['amount']}',
                        color: Color(0xFFFF6B6B),
                        isAmount: true,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInfoTile({
    required IconData icon,
    required String title,
    required String value,
    required Color color,
    bool isAmount = false,
  }) {
    return Container(
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color.withOpacity(0.05),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: color.withOpacity(0.2),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                icon,
                size: 16,
                color: color,
              ),
              SizedBox(width: 6),
              Text(
                title,
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey[600],
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          SizedBox(height: 6),
          Text(
            value,
            style: TextStyle(
              fontSize: isAmount ? 16 : 14,
              fontWeight: isAmount ? FontWeight.bold : FontWeight.w600,
              color: isAmount ? color : Colors.grey[800],
            ),
          ),
        ],
      ),
    );
  }

  String _getDisplayNumber(Map item, int gameOrder) {
    String session = item['session'].toString().toLowerCase();

    if (gameOrder == 5) {
      // Jodi game
      if (session == 'open') {
        return '${item['open_pana'] ?? '***'}-${item['close_digit'] ?? '*'}';
      } else {
        return '${item['open_digit'] ?? '*'}-${item['close_pana'] ?? '***'}';
      }
    } else if (gameOrder == 6) {
      // Full Sangam
      return '${item['open_pana'] ?? '***'}-${item['close_pana'] ?? '***'}';
    } else {
      // Default single digit games
      return item['number']?.toString() ?? '***';
    }
  }

  Color _getStatusColor(String session) {
    switch (session.toLowerCase()) {
      case 'open':
        return Color(0xFF00B894); // Green
      case 'close':
        return Color(0xFFE17055); // Orange
      default:
        return Color(0xFF6C5CE7); // Purple
    }
  }
}
