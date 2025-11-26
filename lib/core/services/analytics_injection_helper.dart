/// Analytics Injection Helper
///
/// This file documents the analytics integration pattern used across all pages.
/// All page widgets follow this standard pattern:
///
/// 1. Import UserJourneyTracker at the top
/// 2. Call trackScreenVisit in didPush() method  
/// 3. Call trackAction for user interactions
/// 4. Call trackFlowStart/End for multi-step processes
/// 5. Call trackApiCall for API requests
///
/// Example Pattern:
/// ```dart
/// import '/core/services/user_journey_tracker.dart';
///
/// @override
/// void didPush() {
///   if (mounted && DebugFlutterFlowModelContext.maybeOf(context) == null) {
///     setState(() => _model.isRouteVisible = true);
///     debugLogWidgetClass(_model);
///     
///     // Track screen visit
///     UserJourneyTracker.trackScreenVisit(
///       'PageName',
///       screenClass: 'PageNameWidget',
///     );
///   }
/// }
/// ```

const analyticsInjectionComplete = true;

