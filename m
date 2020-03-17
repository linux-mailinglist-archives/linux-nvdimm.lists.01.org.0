Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C1B90187B34
	for <lists+linux-nvdimm@lfdr.de>; Tue, 17 Mar 2020 09:28:35 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id ACFC310FC3174;
	Tue, 17 Mar 2020 01:29:24 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=134.134.136.31; helo=mga06.intel.com; envelope-from=patrick.ohly@intel.com; receiver=<UNKNOWN> 
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 7218D1007A84E
	for <linux-nvdimm@lists.01.org>; Tue, 17 Mar 2020 01:29:22 -0700 (PDT)
IronPort-SDR: INapjxxqAIIQb39sSbi0YA3TPo1BJ7CZPC7cJ5VamGwaxkymajkgt5yK1Y2KNNQlcmLtyEIcum
 AGkT5si5FYHg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2020 01:28:31 -0700
IronPort-SDR: healM5eFWf/Kw6gBx4FVqQaJZugrClmjQKDXhbzYDs3BBjEOxoAnAMbVR9ke5InzTm6fiaOhDa
 EEpQ9MKjRDYw==
X-IronPort-AV: E=Sophos;i="5.70,563,1574150400";
   d="scan'208";a="390985809"
Received: from bquerbac-mobl1.amr.corp.intel.com (HELO localhost) ([10.135.40.52])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2020 01:28:28 -0700
From: "Patrick Ohly" <patrick.ohly@intel.com>
To: Vivek Goyal <vgoyal@redhat.com>
Subject: Re: [PATCH 00/20] virtiofs: Add DAX support
In-Reply-To: <20200316130234.GA4013@redhat.com>
Organization: Intel GmbH, Dornacher Strasse 1, D-85622 Feldkirchen/Munich
References: <20200304165845.3081-1-vgoyal@redhat.com> <yrjh1rpzggg4.fsf@pohly-mobl1.fritz.box> <20200316130234.GA4013@redhat.com>
Date: Tue, 17 Mar 2020 09:28:26 +0100
Message-ID: <yrjhlfnzcrmd.fsf@pohly-mobl1.fritz.box>
MIME-Version: 1.0
Message-ID-Hash: XWS6V4CZY2BJVQJDTVPN6ZGIRAOCPBEO
X-Message-ID-Hash: XWS6V4CZY2BJVQJDTVPN6ZGIRAOCPBEO
X-MailFrom: patrick.ohly@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, linux-nvdimm@lists.01.org, virtio-fs@redhat.com, miklos@szeredi.hu, stefanha@redhat.com, dgilbert@redhat.com, mst@redhat.com
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/XWS6V4CZY2BJVQJDTVPN6ZGIRAOCPBEO/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Vivek Goyal <vgoyal@redhat.com> writes:
> We expect users will issue fsync/msync like a regular filesystem to
> make changes persistent. So in that aspect, rejecting MAP_SYNC
> makes sense. I will test and see if current code is rejecting MAP_SYNC
> or not.

Last time I checked, it did. Here's the test program that I wrote for
that:
https://github.com/intel/pmem-csi/blob/ee3200794a1ade49a02df6f359a134115b409e90/test/cmd/pmem-dax-check/main.go

-- 
Best Regards

Patrick Ohly
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
