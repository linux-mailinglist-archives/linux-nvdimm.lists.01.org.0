Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 02A598527C
	for <lists+linux-nvdimm@lfdr.de>; Wed,  7 Aug 2019 19:57:14 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 86CE221309DA3;
	Wed,  7 Aug 2019 10:59:42 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=192.55.52.120; helo=mga04.intel.com;
 envelope-from=vishal.l.verma@intel.com; receiver=linux-nvdimm@lists.01.org 
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id 34F10212FD417
 for <linux-nvdimm@lists.01.org>; Wed,  7 Aug 2019 10:59:41 -0700 (PDT)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
 by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 07 Aug 2019 10:57:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,358,1559545200"; d="scan'208";a="258440082"
Received: from fmsmsx104.amr.corp.intel.com ([10.18.124.202])
 by orsmga001.jf.intel.com with ESMTP; 07 Aug 2019 10:57:10 -0700
Received: from fmsmsx118.amr.corp.intel.com (10.18.116.18) by
 fmsmsx104.amr.corp.intel.com (10.18.124.202) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Wed, 7 Aug 2019 10:57:07 -0700
Received: from fmsmsx114.amr.corp.intel.com ([169.254.6.86]) by
 fmsmsx118.amr.corp.intel.com ([169.254.1.160]) with mapi id 14.03.0439.000;
 Wed, 7 Aug 2019 10:57:07 -0700
From: "Verma, Vishal L" <vishal.l.verma@intel.com>
To: "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>
Subject: [ANNOUNCE] ndctl v66
Thread-Topic: [ANNOUNCE] ndctl v66
Thread-Index: AQHVTUmH/EqgqpIuYE+O3kmhJuGB7w==
Date: Wed, 7 Aug 2019 17:57:06 +0000
Message-ID: <1453308d3f525269a42b6e070af712b6e4515c9c.camel@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.30.5 (3.30.5-1.fc29) 
x-originating-ip: [10.232.112.185]
Content-ID: <FCC5837CB78DE04EB1C34377F5C1011C@intel.com>
MIME-Version: 1.0
X-BeenThere: linux-nvdimm@lists.01.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
List-Unsubscribe: <https://lists.01.org/mailman/options/linux-nvdimm>,
 <mailto:linux-nvdimm-request@lists.01.org?subject=unsubscribe>
List-Archive: <http://lists.01.org/pipermail/linux-nvdimm/>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Subscribe: <https://lists.01.org/mailman/listinfo/linux-nvdimm>,
 <mailto:linux-nvdimm-request@lists.01.org?subject=subscribe>
Cc: "Pathi, Pragyansri" <pragyansri.pathi@intel.com>, "Kasten,
 Robert A" <robert.a.kasten@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

This release incorporates functionality up to the 5.3 kernel, and adds a
number of bug fixes, and improvements.

Highlights include a new command to reconfigure dax devices to
different modes (devdax - default, and system-ram - to hotplug the dax
device as system memory), improvements to ndctl-{read,write,init}-labels
allowing smaller sized reads/writes, usability fixes to ndctl-monitor,
and ndctl-create-namespace, and a fix to ndctl-check-namespace allowing
it to be used on systems with different page sizes.

Shortlog for this release:

Alison Schofield (2):
      ndctl, test: handle backup_keys in security.sh
      ndctl, test: move security.sh to the destructive test list

Dan Williams (14):
      ndctl/dimm: Add 'flags' field to read-labels output
      ndctl/dimm: Add --human support to read-labels
      ndctl/build: Drop -Wpointer-arith
      ndctl/namespace: Handle 'create-namespace' in label-less mode
      ndctl/dimm: Fix init-labels success reporting
      ndctl/test: Fix device-dax bus-model detection
      ndctl/monitor: Allow monitor to be manually moved to the background
      ndctl/dimm: Support small label reads/writes
      ndctl/dimm: Minimize data-transfer for init-labels
      ndctl/dimm: Add offset and size options to {read, write, zero}-labels
      ndctl/dimm: Limit read-labels with --index option
      ndctl/namespace: Minimize label data transfer for autolabel
      ndctl/namespace: Continue region search on 'missing seed' event
      ndctl/namespace: Report ENOSPC when regions are full

Vaibhav Jain (1):
      ndctl, check: Ensure mmap of BTT sections work with 64K page-sizes

Vishal Verma (17):
      libndctl/inject: Refuse error injection for BTT namespaces
      Documentation/ndctl: fix a typo in ndctl(1)
      ndctl/monitor: make the daemon exit message 'info' level
      libdaxctl: add interfaces to get ctx and check device state
      libdaxctl: add interfaces to enable/disable devices
      libdaxctl: add an interface to retrieve the device resource
      libdaxctl: add a 'daxctl_memory' object for memory based operations
      daxctl/list: add target_node for device listings
      daxctl/list: display the mode for a dax device
      daxctl: add a new reconfigure-device command
      Documentation/daxctl: add a man page for daxctl-reconfigure-device
      daxctl: add commands to online and offline memory
      Documentation: Add man pages for daxctl-{on,off}line-memory
      contrib/ndctl: fix region-id completions for daxctl
      contrib/ndctl: add bash-completion for the new daxctl commands
      test: Add a unit test for daxctl-reconfigure-device and friends
      ndctl: release v66
_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
