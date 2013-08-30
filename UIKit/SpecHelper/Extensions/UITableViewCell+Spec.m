#import "UITableViewCell+Spec.h"

@implementation UITableViewCell (Spec)

- (void)tap {
    UIView *currentView = self;
    while (currentView.superview != nil && ![currentView isKindOfClass:[UITableView class]]) {
        currentView = currentView.superview;
    }

    NSAssert(currentView, @"Cell must be in a table view in order to be tapped!");
    UITableView *tableView = (UITableView *)currentView;

    NSIndexPath *indexPath = [tableView indexPathForCell:self];

    if ([tableView.delegate respondsToSelector:@selector(tableView:willSelectRowAtIndexPath:)]) {
        indexPath = [tableView.delegate tableView:tableView willSelectRowAtIndexPath:indexPath];
    }

    if (indexPath != nil) {
        [tableView selectRowAtIndexPath:indexPath animated:NO scrollPosition:UITableViewScrollPositionNone];
        if ([tableView.delegate respondsToSelector:@selector(tableView:didSelectRowAtIndexPath:)]) {
            [tableView.delegate tableView:tableView didSelectRowAtIndexPath:indexPath];
        }
    }
}

@end
