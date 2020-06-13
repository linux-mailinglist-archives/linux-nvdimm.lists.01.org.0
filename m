Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 73DD31F84DC
	for <lists+linux-nvdimm@lfdr.de>; Sat, 13 Jun 2020 21:19:37 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 28FF110109140;
	Sat, 13 Jun 2020 12:19:35 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=79.96.170.134; helo=cloudserver094114.home.pl; envelope-from=rjw@rjwysocki.net; receiver=<UNKNOWN> 
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 04CFD10106A08
	for <linux-nvdimm@lists.01.org>; Sat, 13 Jun 2020 12:19:32 -0700 (PDT)
Received: from 89-77-60-66.dynamic.chello.pl (89.77.60.66) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.415)
 id b5415c95c99b9eab; Sat, 13 Jun 2020 21:19:29 +0200
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [RFT][PATCH 0/3] ACPI: ACPICA / OSL: Avoid unmapping ACPI memory inside of the AML interpreter
Date: Sat, 13 Jun 2020 21:19:28 +0200
Message-ID: <6131168.ASH3qCSnW2@kreacher>
In-Reply-To: <318372766.6LKUBsbRXE@kreacher>
References: <158889473309.2292982.18007035454673387731.stgit@dwillia2-desk3.amr.corp.intel.com> <318372766.6LKUBsbRXE@kreacher>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Message-ID-Hash: MYLL427PYNEAE2UTP3NOXDFYGNEUOCMZ
X-Message-ID-Hash: MYLL427PYNEAE2UTP3NOXDFYGNEUOCMZ
X-MailFrom: rjw@rjwysocki.net
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Erik Kaneda <erik.kaneda@intel.com>, rafael.j.wysocki@intel.com, Len Brown <lenb@kernel.org>, Borislav Petkov <bp@alien8.de>, James Morse <james.morse@arm.com>, Myron Stowe <myron.stowe@redhat.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, linux-nvdimm@lists.01.org, Bob Moore <robert.moore@intel.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/MYLL427PYNEAE2UTP3NOXDFYGNEUOCMZ/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Transfer-Encoding: 7bit

On Wednesday, June 10, 2020 2:17:04 PM CEST Rafael J. Wysocki wrote:
> Hi All,
> 
> This series is to address the problem with RCU synchronization occurring,
> possibly relatively often, inside of acpi_ex_system_memory_space_handler(),
> when the namespace and interpreter mutexes are held.
> 
> The basic idea is to avoid the actual unmapping of memory in
> acpi_ex_system_memory_space_handler() by making it take the advantage of the
> reference counting of memory mappings utilized by the OSL layer in Linux.
> 
> The basic assumption in patch [1/3] is that if the special
> ACPI_OS_MAP_MEMORY_FAST_PATH() macro is present, it can be used to increment
> the reference counter of a known-existing memory mapping in the OS layer
> which then is dropped by the subsequent acpi_os_unmap_memory() without
> unmapping the address range at hand.  That can be utilized by
> acpi_ex_system_memory_space_handler() to prevent the reference counters of
> all mappings used by it from dropping down to 0 (which also prevents the
> address ranges associated with them from being unmapped) so that they can
> be unmapped later (specifically, at the operation region deactivation time).
> 
> Patch [2/3] defers the unmapping even further, until the namespace and
> interpreter mutexes are released, to avoid invoking the RCU synchronization
> under theses mutexes.
> 
> Finally, patch [3/3] changes the OS layer in Linux to provide the
> ACPI_OS_MAP_MEMORY_FAST_PATH() macro.
> 
> Note that if this macro is not defined, the code works the way it used to.
> 
> The series is available from the git branch at
> 
>  git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
>  acpica-osl
> 
> for easier testing.

Please disregard this patch series, it will be replaced by a new one which
already is there in the acpica-osl branch above.

Thanks!


_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
