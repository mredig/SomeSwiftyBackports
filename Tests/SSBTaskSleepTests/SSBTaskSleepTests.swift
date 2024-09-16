import Testing
@testable import SSBTaskSleep
import Foundation

@Test
func testTaskSecondSleep() async throws {
	let start = getTime()

	try await Task.sleep(backportDuration: .seconds(1))

	let end = getTime()

	let difference = abs(end.seconds - start.seconds)

	#expect((0.93..<1.07).contains(difference))
}

@Test
func testTaskMSSleep() async throws {
	let start = getTime()

	try await Task.sleep(backportDuration: .milliseconds(500))

	let end = getTime()

	let difference = abs(end.seconds - start.seconds)
	print(difference)

	#expect((0.49..<0.55).contains(difference))
}

@Test
func testTaskuSSleep() async throws {
	let start = getTime()

	try await Task.sleep(backportDuration: .microseconds(5000))

	let end = getTime()

	let difference = abs(end.seconds - start.seconds)
	print(difference)

	#expect((0.005..<0.01).contains(difference))
}

@Test
func testTaskNSSleep() async throws {
	let start = getTime()

	try await Task.sleep(backportDuration: .nanoseconds(5_000_000))

	let end = getTime()

	let difference = abs(end.seconds - start.seconds)
	print(difference)

	#expect((0.005..<0.01).contains(difference))
}


private func getTime() -> timespec {
	var timeHolder = timespec()
	clock_gettime(CLOCK_MONOTONIC_RAW, &timeHolder)
	return timeHolder
}

private extension timespec {
	var seconds: Double {
		Double(tv_sec) + (Double(tv_nsec) / .oneBillion)
	}
}
