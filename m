Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 670DFDF599
	for <lists+linux-nvdimm@lfdr.de>; Mon, 21 Oct 2019 21:04:29 +0200 (CEST)
Received: from new-ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 34BE01007A2F5;
	Mon, 21 Oct 2019 12:04:24 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=192.55.52.151; helo=mga17.intel.com; envelope-from=vishal.l.verma@intel.com; receiver=<UNKNOWN> 
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 6340A1007B52B
	for <linux-nvdimm@lists.01.org>; Mon, 21 Oct 2019 10:13:17 -0700 (PDT)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 21 Oct 2019 10:11:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.67,324,1566889200";
   d="scan'208";a="187606539"
Received: from fmsmsx103.amr.corp.intel.com ([10.18.124.201])
  by orsmga007.jf.intel.com with ESMTP; 21 Oct 2019 10:11:32 -0700
Received: from fmsmsx125.amr.corp.intel.com (10.18.125.40) by
 FMSMSX103.amr.corp.intel.com (10.18.124.201) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Mon, 21 Oct 2019 10:11:32 -0700
Received: from fmsmsx114.amr.corp.intel.com ([169.254.6.30]) by
 FMSMSX125.amr.corp.intel.com ([169.254.2.239]) with mapi id 14.03.0439.000;
 Mon, 21 Oct 2019 10:11:32 -0700
From: "Verma, Vishal L" <vishal.l.verma@intel.com>
To: "jmoyer@redhat.com" <jmoyer@redhat.com>, "Weiny, Ira"
	<ira.weiny@intel.com>
Subject: Re: [ndctl patch 3/4] query_fw_finish_status: get rid of redundant
 variable
Thread-Topic: [ndctl patch 3/4] query_fw_finish_status: get rid of redundant
 variable
Thread-Index: AQHVhffdKVQAtmMLOEqII07S9c0vNKdhdfUAgARYnoA=
Date: Mon, 21 Oct 2019 17:11:31 +0000
Message-ID: <4d82d2c90961587f6b5d1868f900b421a8055ec4.camel@intel.com>
References: <20191018202302.8122-1-jmoyer@redhat.com>
	 <20191018202302.8122-4-jmoyer@redhat.com>
	 <20191018205424.GA12760@iweiny-DESK2.sc.intel.com>
	 <x49sgnp7ohp.fsf@segfault.boston.devel.redhat.com>
	 <20191018224918.GB12995@iweiny-DESK2.sc.intel.com>
In-Reply-To: <20191018224918.GB12995@iweiny-DESK2.sc.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.30.5 (3.30.5-1.fc29) 
x-originating-ip: [10.232.112.164]
Content-ID: <E3A2278212EB85479CCBAE7EFCE42D0C@intel.com>
MIME-Version: 1.0
Message-ID-Hash: 7XRNWSVS22DHND5EMW3M67BBXCFYTP2G
X-Message-ID-Hash: 7XRNWSVS22DHND5EMW3M67BBXCFYTP2G
X-MailFrom: vishal.l.verma@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/7XRNWSVS22DHND5EMW3M67BBXCFYTP2G/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit


On Fri, 2019-10-18 at 15:49 -0700, Ira Weiny wrote:
> On Fri, Oct 18, 2019 at 05:06:10PM -0400, Jeff Moyer wrote:
> > Ira Weiny <ira.weiny@intel.com> writes:
> > 
> > > On Fri, Oct 18, 2019 at 04:23:01PM -0400, Jeff Moyer wrote:
> > > > The 'done' variable only adds confusion.
> > > > 
> > > >  			goto out;
> > > >  		}
> > > > -	} while (!done);
> > > > +	} while (true);
> > > 
> > > I'm not a fan of "while (true)".  But I'm not the maintainer.  The Logic seems
> > > fine otherwise.
> > 
> > The way things stand today is a mashup of goto vs. break.  I'll
> > follow-up with fixed up patch next week if there is consensus on the
> > change.  If you have a suggestion for a better way, that's welcome as
> > well.
> 
> Yea that is the reason I did not object strongly.  I don't have a good idea of
> how to clean the loop up without a pretty big refactoring.  Which I'm not
> prepared to do.  :-/  So if Vishal is ok with it, I am.

I looked into this - and I agree that while (true) isn't the greatest.
I think we can refactor it to loop off the timeout value, and that keeps
the loop always bounded. For other cases we break out as usual.

For now, we can go with the simpler fixup, and revisit the bigger
refactoring later.

Thanks,
-Vishal
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
