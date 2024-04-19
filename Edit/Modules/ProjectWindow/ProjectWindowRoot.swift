import SwiftUI

import DocumentContent
import Navigator
import WindowTreatment
import Search
import Status

struct ProjectWindowRoot<Content: View>: View {
	@Environment(WindowStateModel.self) private var model
	@Environment(\.windowState) private var windowState

	let content: Content

	init(content: () -> Content) {
		self.content = content()
	}
	
	var body: some View {
		VStack(spacing: 0) {
			content
			if model.searchActive {
				SearchBar()
			}
		}
		.frame(minWidth: 450, minHeight: 300)
		.environment(\.theme, model.currentTheme)
		.environment(\.projectContext, model.projectContext)
		.environment(\.documentContext, model.documentContext)
		.environment(model.navigatorModel)
		.environment(model.diagnosticsModel)
		.ignoresSafeArea()
		.onChange(of: windowState) { model.windowStateChanged($0, $1) }
	}
}
