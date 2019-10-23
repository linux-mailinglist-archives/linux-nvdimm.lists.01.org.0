Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A8A47E235A
	for <lists+linux-nvdimm@lfdr.de>; Wed, 23 Oct 2019 21:41:20 +0200 (CEST)
Received: from new-ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 32895100EEB8E;
	Wed, 23 Oct 2019 12:42:46 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=134.134.136.20; helo=mga02.intel.com; envelope-from=vishal.l.verma@intel.com; receiver=<UNKNOWN> 
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 0C66D100EEB8C
	for <linux-nvdimm@lists.01.org>; Wed, 23 Oct 2019 12:42:43 -0700 (PDT)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 23 Oct 2019 12:41:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,222,1569308400";
   d="scan'208";a="188354486"
Received: from fmsmsx106.amr.corp.intel.com ([10.18.124.204])
  by orsmga007.jf.intel.com with ESMTP; 23 Oct 2019 12:41:16 -0700
Received: from fmsmsx121.amr.corp.intel.com (10.18.125.36) by
 FMSMSX106.amr.corp.intel.com (10.18.124.204) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Wed, 23 Oct 2019 12:41:15 -0700
Received: from fmsmsx114.amr.corp.intel.com ([169.254.6.30]) by
 fmsmsx121.amr.corp.intel.com ([169.254.6.22]) with mapi id 14.03.0439.000;
 Wed, 23 Oct 2019 12:41:15 -0700
From: "Verma, Vishal L" <vishal.l.verma@intel.com>
To: "Williams, Dan J" <dan.j.williams@intel.com>, "linux-nvdimm@lists.01.org"
	<linux-nvdimm@lists.01.org>
Subject: Re: [ndctl PATCH 3/4] test/dax.sh: Validate huge page mappings
Thread-Topic: [ndctl PATCH 3/4] test/dax.sh: Validate huge page mappings
Thread-Index: AQHVhp3YA9l1C9N+nECXG4rwhhlK3qdpGYQAgAACQIA=
Date: Wed, 23 Oct 2019 19:41:14 +0000
Message-ID: <5e6086c2a48bce222aaedb8bb121bc64bd7fa445.camel@intel.com>
References: <157150317870.3940762.5638079137146963300.stgit@dwillia2-desk3.amr.corp.intel.com>
	 <157150319417.3940762.12887432367621574807.stgit@dwillia2-desk3.amr.corp.intel.com>
	 <77f96d5eade3b83e1ef847fd2b5533f3eb0a9cea.camel@intel.com>
In-Reply-To: <77f96d5eade3b83e1ef847fd2b5533f3eb0a9cea.camel@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.30.5 (3.30.5-1.fc29) 
x-originating-ip: [10.232.112.164]
Content-ID: <D9BD11D7DEF4054BA691F42E897F509D@intel.com>
MIME-Version: 1.0
Message-ID-Hash: HSZTGPX454SVHAPZF56PCVQTQJO46JCH
X-Message-ID-Hash: HSZTGPX454SVHAPZF56PCVQTQJO46JCH
X-MailFrom: vishal.l.verma@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/HSZTGPX454SVHAPZF56PCVQTQJO46JCH/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Wed, 2019-10-23 at 19:33 +0000, Verma, Vishal L wrote:
> 
> > @@ -91,4 +111,4 @@ json=$($NDCTL create-namespace -m raw -f -e $dev)
> >  eval $(json2var <<< "$json")
> >  [ $mode != "fsdax" ] && echo "fail: $LINENO" &&  exit 1
> 
> same comment about quoting "$mode". If 'mode' happens to be empty for
> soem reason, we want to fail with the error message - instead the above
> will fail with a syntax error.

Sorry ignore this - that was a context line..

_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
