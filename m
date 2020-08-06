Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C0E0923E278
	for <lists+linux-nvdimm@lfdr.de>; Thu,  6 Aug 2020 21:45:02 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id C6E8412BD2D02;
	Thu,  6 Aug 2020 12:45:00 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=192.55.52.120; helo=mga04.intel.com; envelope-from=vishal.l.verma@intel.com; receiver=<UNKNOWN> 
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id B01CA12ADC877
	for <linux-nvdimm@lists.01.org>; Thu,  6 Aug 2020 12:44:55 -0700 (PDT)
IronPort-SDR: UtzYtgsATkVXa7RQ/urbDTnBS+LGH3KkPwywqNwe7mHEhO1A8h0nUG/ymPwQjagAyn+reCnBWa
 wR2jCWy2iNmg==
X-IronPort-AV: E=McAfee;i="6000,8403,9705"; a="150365735"
X-IronPort-AV: E=Sophos;i="5.75,443,1589266800";
   d="scan'208";a="150365735"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2020 12:44:55 -0700
IronPort-SDR: nycQsiqLFmbGL0LtGtGFYgb+gTscrpr/0xgzIYgwxbr49DUCUbwZL9hBeN1k9fG89L9bEYw1DC
 JtW7ybZiE1XA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,443,1589266800";
   d="scan'208";a="323540390"
Received: from orsmsx604.amr.corp.intel.com ([10.22.229.17])
  by orsmga008.jf.intel.com with ESMTP; 06 Aug 2020 12:44:54 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX604.amr.corp.intel.com (10.22.229.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Thu, 6 Aug 2020 12:44:54 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Thu, 6 Aug 2020 12:44:54 -0700
Received: from orsmsx612.amr.corp.intel.com ([10.22.229.25]) by
 ORSMSX612.amr.corp.intel.com ([10.22.229.25]) with mapi id 15.01.1713.004;
 Thu, 6 Aug 2020 12:44:54 -0700
From: "Verma, Vishal L" <vishal.l.verma@intel.com>
To: "linux-mm@kvack.org" <linux-mm@kvack.org>, "willy@infradead.org"
	<willy@infradead.org>, "linux-fsdevel@vger.kernel.org"
	<linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH 0/4] Remove nrexceptional tracking
Thread-Topic: [PATCH 0/4] Remove nrexceptional tracking
Thread-Index: AQHWanrcgiyE+gZ1T06GDixOiuOZv6kr8b+A
Date: Thu, 6 Aug 2020 19:44:54 +0000
Message-ID: <898e058f12c7340703804ed9d05df5ead9ecb50d.camel@intel.com>
References: <20200804161755.10100-1-willy@infradead.org>
In-Reply-To: <20200804161755.10100-1-willy@infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.32.5 (3.32.5-1.fc30) 
x-originating-ip: [10.254.22.71]
Content-ID: <6DAC71C4E387FB48878F27E18F96C0B8@intel.com>
MIME-Version: 1.0
Message-ID-Hash: ESP5GAL36JLFVY4MTOXNZ4LAG32AGU54
X-Message-ID-Hash: ESP5GAL36JLFVY4MTOXNZ4LAG32AGU54
X-MailFrom: vishal.l.verma@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/ESP5GAL36JLFVY4MTOXNZ4LAG32AGU54/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Tue, 2020-08-04 at 17:17 +0100, Matthew Wilcox (Oracle) wrote:
> We actually use nrexceptional for very little these days.  It's a
> constant
> source of pain with the THP patches because we don't know how large a
> shadow entry is, so either we have to ask the xarray how many indices
> it covers, or store that information in the shadow entry (and reduce
> the amount of other information in the shadow entry proportionally).
> While tracking down the most recent case of "evict tells me I've got
> the accounting wrong again", I wondered if it might not be simpler to
> just remove it.  So here's a patch set to do just that.  I think each
> of these patches is an improvement in isolation, but the combination
> of
> all four is larger than the sum of its parts.
> 
> I'm running xfstests on this patchset right now.  If one of the DAX
> people could try it out, that'd be fantastic.
> 
> Matthew Wilcox (Oracle) (4):
>   mm: Introduce and use page_cache_empty
>   mm: Stop accounting shadow entries
>   dax: Account DAX entries as nrpages
>   mm: Remove nrexceptional from inode

Hi Matthew,

I applied these on top of 5.8 and ran them through the nvdimm unit test
suite, and saw some test failures. The first failing test signature is:

  + umount test_dax_mnt
  ./dax-ext4.sh: line 62: 15749 Segmentation fault      umount $MNT
  FAIL dax-ext4.sh (exit status: 139)

The line is: https://github.com/pmem/ndctl/blob/master/test/dax.sh#L79
And the failing umount happens right after 'run_test', which calls this:
https://github.com/pmem/ndctl/blob/master/test/dax-pmd.c


> 
>  fs/block_dev.c          |  2 +-
>  fs/dax.c                |  8 ++++----
>  fs/inode.c              |  2 +-
>  include/linux/fs.h      |  2 --
>  include/linux/pagemap.h |  5 +++++
>  mm/filemap.c            | 15 ---------------
>  mm/truncate.c           | 19 +++----------------
>  mm/workingset.c         |  1 -
>  8 files changed, 14 insertions(+), 40 deletions(-)
> 
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
