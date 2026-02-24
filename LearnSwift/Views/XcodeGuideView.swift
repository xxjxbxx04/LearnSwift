import SwiftUI

struct XcodeGuideView: View {
    var body: some View {
        NavigationStack {
            Group {
                if XcodeGuideData.sections.isEmpty {
                    emptyState
                } else {
                    List(XcodeGuideData.sections) { section in
                        NavigationLink(destination: XcodeGuideSectionDetail(section: section)) {
                            XcodeGuideSectionRow(section: section)
                        }
                        .listRowBackground(Color(.secondarySystemGroupedBackground))
                        .listRowSeparatorTint(Color(.separator).opacity(0.5))
                    }
                    .listStyle(.insetGrouped)
                    .scrollContentBackground(.hidden)
                    .background(Color(.systemGroupedBackground))
                }
            }
            .navigationTitle("Xcode Guide")
            .navigationBarTitleDisplayMode(.large)
        }
    }

    private var emptyState: some View {
        VStack(spacing: 16) {
            Image(systemName: "display")
                .font(.system(size: 48))
                .foregroundColor(.secondary)

            Text("No Guides Available")
                .font(.title2.bold())
                .foregroundColor(.primary)

            Text("Check back later for Xcode guides.")
                .font(.subheadline)
                .foregroundColor(.secondary)
                .multilineTextAlignment(.center)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(.systemGroupedBackground))
    }
}

// MARK: - Section Row

private struct XcodeGuideSectionRow: View {
    let section: XcodeGuideSection

    var body: some View {
        HStack(alignment: .top, spacing: 12) {
            Text(section.emoji)
                .font(.title2)
                .frame(width: 40, height: 40)
                .background(Color(.tertiarySystemBackground))
                .clipShape(RoundedRectangle(cornerRadius: 10))

            VStack(alignment: .leading, spacing: 4) {
                Text(section.title)
                    .font(.headline)
                    .foregroundColor(.primary)

                Text(section.overview)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                    .lineLimit(2)
            }
        }
        .padding(.vertical, 4)
    }
}

// MARK: - Section Detail View

struct XcodeGuideSectionDetail: View {
    let section: XcodeGuideSection

    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                // Header
                sectionHeader

                // Steps
                VStack(spacing: 12) {
                    HStack {
                        Text("Steps")
                            .font(.title3.bold())
                            .foregroundColor(.primary)
                        Spacer()
                    }
                    .padding(.horizontal, 16)

                    ForEach(Array(section.steps.enumerated()), id: \.element.id) { index, step in
                        XcodeGuideStepView(number: index + 1, step: step)
                    }
                }

                // Pro Tip
                if let proTip = section.proTip {
                    ProTipCard(tip: proTip)
                        .padding(.horizontal, 16)
                }
            }
            .padding(.bottom, 32)
        }
        .background(Color(.systemGroupedBackground))
        .navigationTitle(section.title)
        .navigationBarTitleDisplayMode(.inline)
    }

    private var sectionHeader: some View {
        VStack(spacing: 14) {
            ZStack {
                LinearGradient(
                    colors: [.blue, .indigo],
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )

                VStack(spacing: 10) {
                    Text(section.emoji)
                        .font(.system(size: 56))

                    Text(section.title)
                        .font(.system(size: 24, weight: .bold, design: .rounded))
                        .foregroundColor(.white)
                        .multilineTextAlignment(.center)
                }
                .padding(.vertical, 32)
                .padding(.horizontal, 24)
            }
            .clipShape(RoundedRectangle(cornerRadius: 20))
            .padding(.horizontal, 16)

            Text(section.overview)
                .font(.subheadline)
                .foregroundColor(.secondary)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 20)
        }
        .padding(.top, 16)
    }
}

// MARK: - Step View

private struct XcodeGuideStepView: View {
    let number: Int
    let step: XcodeGuideStep

    var body: some View {
        HStack(alignment: .top, spacing: 14) {
            // Step number badge
            ZStack {
                Circle()
                    .fill(LinearGradient(
                        colors: [.blue, .indigo],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    ))
                    .frame(width: 32, height: 32)

                Text("\(number)")
                    .font(.system(.subheadline, design: .rounded).bold())
                    .foregroundColor(.white)
            }
            .padding(.top, 2)

            VStack(alignment: .leading, spacing: 6) {
                Text(step.instruction)
                    .font(.subheadline.bold())
                    .foregroundColor(.primary)
                    .fixedSize(horizontal: false, vertical: true)

                Text(step.detail)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                    .fixedSize(horizontal: false, vertical: true)
            }
        }
        .padding(14)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color(.secondarySystemGroupedBackground))
        .clipShape(RoundedRectangle(cornerRadius: 14))
        .padding(.horizontal, 16)
    }
}

// MARK: - Pro Tip Card

private struct ProTipCard: View {
    let tip: String

    var body: some View {
        HStack(alignment: .top, spacing: 12) {
            Image(systemName: "lightbulb.fill")
                .foregroundColor(.yellow)
                .font(.title3)
                .padding(.top, 1)

            VStack(alignment: .leading, spacing: 6) {
                Text("Pro Tip")
                    .font(.headline)
                    .foregroundColor(.primary)

                Text(tip)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                    .fixedSize(horizontal: false, vertical: true)
            }
        }
        .padding(16)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color.yellow.opacity(0.1))
        .clipShape(RoundedRectangle(cornerRadius: 16))
        .overlay(
            RoundedRectangle(cornerRadius: 16)
                .strokeBorder(Color.yellow.opacity(0.4), lineWidth: 1)
        )
    }
}

#Preview {
    XcodeGuideView()
}
