Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 781A8E77CF
	for <lists+linux-nvdimm@lfdr.de>; Mon, 28 Oct 2019 18:47:25 +0100 (CET)
Received: from new-ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 40FCC100EA633;
	Mon, 28 Oct 2019 10:48:13 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=192.55.52.136; helo=mga12.intel.com; envelope-from=vishal.l.verma@intel.com; receiver=<UNKNOWN> 
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 07A96100EA630
	for <linux-nvdimm@lists.01.org>; Mon, 28 Oct 2019 10:48:10 -0700 (PDT)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 28 Oct 2019 10:47:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,240,1569308400";
   d="scan'208";a="203334479"
Received: from fmsmsx103.amr.corp.intel.com ([10.18.124.201])
  by orsmga006.jf.intel.com with ESMTP; 28 Oct 2019 10:47:20 -0700
Received: from fmsmsx115.amr.corp.intel.com (10.18.116.19) by
 FMSMSX103.amr.corp.intel.com (10.18.124.201) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Mon, 28 Oct 2019 10:47:20 -0700
Received: from fmsmsx114.amr.corp.intel.com ([169.254.6.30]) by
 fmsmsx115.amr.corp.intel.com ([169.254.4.204]) with mapi id 14.03.0439.000;
 Mon, 28 Oct 2019 10:47:19 -0700
From: "Verma, Vishal L" <vishal.l.verma@intel.com>
To: "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>
CC: "Williams, Dan J" <dan.j.williams@intel.com>
Subject: [ANNOUNCE] ndctl v67
Thread-Topic: [ANNOUNCE] ndctl v67
Thread-Index: AQHVjbe+lf8w2AHoCUG2rtXeyj+ILw==
Date: Mon, 28 Oct 2019 17:47:18 +0000
Message-ID: <6936962a6a0dcf8af1b7a53f6b334464ea6c27c1.camel@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.30.5 (3.30.5-1.fc29) 
x-originating-ip: [10.232.112.164]
Content-ID: <16405D32E803444FA29B40EEBE21B729@intel.com>
MIME-Version: 1.0
Message-ID-Hash: TSLLVZVEGX74FZTKGXERF3DH2ZKDFGCX
X-Message-ID-Hash: TSLLVZVEGX74FZTKGXERF3DH2ZKDFGCX
X-MailFrom: vishal.l.verma@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/TSLLVZVEGX74FZTKGXERF3DH2ZKDFGCX/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

This release incorporates functionality up to the 5.4 kernel, and adds a
number of bug fixes, and improvements.

Highlights include small changes for PowerPC compatibility, improvements
to the dax.sh unit test to detect failures in mapping huge pages,
support for the 'security frozen' attribute, user experience
improvements for the daxctl-reconfigure-device command, including an
option to specify movable vs. non-movable state for onlining memory, and
an option to allow create-namespaces to create a maximal configuration
until it exhausts all available region capacity.

The shortlog for this release is appended below.


Aneesh Kumar K.V (1):
      ndctl: Reuse the align value from the original namespace on reconfiguration

Dan Williams (10):
      ndctl/lib: Fix duplicate bus detection
      ndctl/test: Add xfs reflink dependency
      daxctl/test: Skip daxctl-devices.sh on older kernels
      ndctl/dimm: Add support for separate security-frozen attribute
      ndctl/namespace: Fix 'clear-error -s' excessive scrubbing
      test/dax.sh: Fix failure reporting / handling
      test/dax.sh: Fix xfs 2M alignment
      test/dax.sh: Validate huge page mappings
      test/dax.sh: Make dax.sh more robust vs small namespaces
      test/dax.sh: Split into ext4 and xfs tests

Jeff Moyer (4):
      util/abspath: cleanup prefix_filename
      fix building of tags tables
      query_fw_finish_status: get rid of redundant variable
      load-keys: get rid of duplicate assignment

Naoya Horiguchi (1):
      Documentation/ndctl: fix typo in ndctl-clear-errors.txt

Vishal Verma (21):
      Documentation/namespace-description: Clarify label-less restrictions
      ndctl/check-namespace: improve error message in absence of a BTT
      libdaxctl: point to migrate-device-model for dax-class errors
      Documentation: refactor 'bus options' into its own include
      Documentation: clarify bus/dimm/region filtering
      ndctl/namespace: add a --continue option to create namespaces greedily
      libdaxctl: fix the system-ram capability check
      libdaxctl: fix device reconfiguration with builtin drivers
      libndctl: Fix a potentially non NUL-terminated string operation
      libdaxctl: fix memory leaks with daxctl_memory objects
      libdaxctl: refactor path construction in op_for_one_memblock()
      libdaxctl: refactor memblock_is_online() checks
      daxctl/device.c: fix json output omission for reconfigure-device
      libdaxctl: add an API to determine if memory is movable
      libdaxctl: allow memblock_in_dev() to return an error
      daxctl: show a 'movable' attribute in device listings
      daxctl: detect races when onlining memory blocks
      Documentation: clarify memory movablity for reconfigure-device
      libdaxctl: add an API to online memory in a non-movable state
      daxctl: add --no-movable option for onlining memory
      ndctl: release v67
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
