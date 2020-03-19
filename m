Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 811BB18ABA5
	for <lists+linux-nvdimm@lfdr.de>; Thu, 19 Mar 2020 05:14:45 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 330111003EC78;
	Wed, 18 Mar 2020 21:15:34 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=192.55.52.151; helo=mga17.intel.com; envelope-from=vishal.l.verma@intel.com; receiver=<UNKNOWN> 
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id B9E311003EC78
	for <linux-nvdimm@lists.01.org>; Wed, 18 Mar 2020 21:14:29 -0700 (PDT)
IronPort-SDR: bMUTlmIQLhWKvly1zw2LLEHSrQCbW1VG+rQPunL+035UuCkfvy950m8eecosWUyRaOvixDVUfz
 WFanffX+PgeA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2020 21:13:38 -0700
IronPort-SDR: L4gJiULefzLsK8c4kEnFK8mkEO2SvGPW7W+C9UglACM1iXE60iy+w92LsFpedP6/XVzANln9OB
 I7ATVj5+r/VA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,570,1574150400";
   d="scan'208";a="263609710"
Received: from fmsmsx105.amr.corp.intel.com ([10.18.124.203])
  by orsmga002.jf.intel.com with ESMTP; 18 Mar 2020 21:13:38 -0700
Received: from fmsmsx115.amr.corp.intel.com (10.18.116.19) by
 FMSMSX105.amr.corp.intel.com (10.18.124.203) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Wed, 18 Mar 2020 21:13:37 -0700
Received: from fmsmsx125.amr.corp.intel.com ([169.254.2.68]) by
 fmsmsx115.amr.corp.intel.com ([169.254.4.81]) with mapi id 14.03.0439.000;
 Wed, 18 Mar 2020 21:13:37 -0700
From: "Verma, Vishal L" <vishal.l.verma@intel.com>
To: "Williams, Dan J" <dan.j.williams@intel.com>, "linux-nvdimm@lists.01.org"
	<linux-nvdimm@lists.01.org>
Subject: Re: [ndctl PATCH 00/36] Multiple topics / backlog for v68
Thread-Topic: [ndctl PATCH 00/36] Multiple topics / backlog for v68
Thread-Index: AQHV7z/gIHclahVf40GBcnxvRNm0/ahP4F4A
Date: Thu, 19 Mar 2020 04:13:37 +0000
Message-ID: <0144252ef32ea7317718d0738d30347adc870b92.camel@intel.com>
References: <158300760415.2141307.14060353322051900501.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <158300760415.2141307.14060353322051900501.stgit@dwillia2-desk3.amr.corp.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.32.5 (3.32.5-1.fc30) 
x-originating-ip: [10.254.177.250]
Content-ID: <DC9ADE9B6DC80B4291B08434EB5FC3CD@intel.com>
MIME-Version: 1.0
Message-ID-Hash: 4Y3HPTGKVEKQJZIYH5TW6CG34MN36ZVH
X-Message-ID-Hash: 4Y3HPTGKVEKQJZIYH5TW6CG34MN36ZVH
X-MailFrom: vishal.l.verma@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/4Y3HPTGKVEKQJZIYH5TW6CG34MN36ZVH/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Sat, 2020-02-29 at 12:20 -0800, Dan Williams wrote:
> Changes from review:
> - Add NDCTL_LIST_LINT to not regress list output (Jeff)
> - Add kernel-doc description for ndctl_region_set_align() (Jeff)
> 
> ---
> 
> About half of these have been posted previously, but have been reworked
> and revised as they have percolated in my tree relative to other
> arriving features. Yes, it is quite a lot to ingest at once, but given
> the interdependencies and need to catch up I decided to post it all
> together.
> 
> The recommendation on how to review is to start with the new tests,
> those introduce some new commands, and those new commands introduce some
> new library routines. The rest are miscellaneous updates, fixes, and
> cleanups.
> 
This all looks good to me - you can add:
Reviewed-by: Vishal Verma <vishal.l.verma@intel.com>


_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
