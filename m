Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 88BCB2A4F21
	for <lists+linux-nvdimm@lfdr.de>; Tue,  3 Nov 2020 19:42:23 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id B22AA100A01B2;
	Tue,  3 Nov 2020 10:42:21 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=192.55.52.120; helo=mga04.intel.com; envelope-from=ira.weiny@intel.com; receiver=<UNKNOWN> 
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 8C678100A01AF
	for <linux-nvdimm@lists.01.org>; Tue,  3 Nov 2020 10:42:19 -0800 (PST)
IronPort-SDR: GfJj+vya/iJdz8xqeE3E3lKSSu8p7hnju9AY6TpLpU+IkgaYpLKDpBbArV19hEU5VGwAdBZXMU
 oLIl63PPn11A==
X-IronPort-AV: E=McAfee;i="6000,8403,9794"; a="166517121"
X-IronPort-AV: E=Sophos;i="5.77,448,1596524400";
   d="scan'208";a="166517121"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2020 10:42:19 -0800
IronPort-SDR: NHUhhr4Ld0+ktxaexVqc9ly5ziPRS5Y+EjthlhRuorVcxAnBGj8aOQJlCSYv9leRTjjDuriVDY
 sxTjbk20XkgQ==
X-IronPort-AV: E=Sophos;i="5.77,448,1596524400";
   d="scan'208";a="528593430"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.147])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2020 10:42:19 -0800
Date: Tue, 3 Nov 2020 10:42:18 -0800
From: Ira Weiny <ira.weiny@intel.com>
To: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH V2 05/10] x86/pks: Add PKS kernel API
Message-ID: <20201103184218.GB1531489@iweiny-DESK2.sc.intel.com>
References: <20201102205320.1458656-1-ira.weiny@intel.com>
 <20201102205320.1458656-6-ira.weiny@intel.com>
 <20201103065024.GC75930@kroah.com>
 <20201103175335.GA1531489@iweiny-DESK2.sc.intel.com>
 <20201103181407.GA83845@kroah.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20201103181407.GA83845@kroah.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
Message-ID-Hash: 5ILJKFZ5W4CCGQFOWDI54ZFUSWLWITTX
X-Message-ID-Hash: 5ILJKFZ5W4CCGQFOWDI54ZFUSWLWITTX
X-MailFrom: ira.weiny@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Dave Hansen <dave.hansen@linux.intel.com>, Fenghua Yu <fenghua.yu@intel.com>, x86@kernel.org, Andrew Morton <akpm@linux-foundation.org>, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-nvdimm@lists.01.org, linux-mm@kvack.org, linux-kselftest@vger.kernel.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/5ILJKFZ5W4CCGQFOWDI54ZFUSWLWITTX/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Tue, Nov 03, 2020 at 07:14:07PM +0100, Greg KH wrote:
> On Tue, Nov 03, 2020 at 09:53:36AM -0800, Ira Weiny wrote:
> > On Tue, Nov 03, 2020 at 07:50:24AM +0100, Greg KH wrote:
> > > On Mon, Nov 02, 2020 at 12:53:15PM -0800, ira.weiny@intel.com wrote:
> > > > From: Fenghua Yu <fenghua.yu@intel.com>
> > > > 
> > 
> > [snip]
> > 
> > > > diff --git a/include/linux/pkeys.h b/include/linux/pkeys.h
> > > > index 2955ba976048..0959a4c0ca64 100644
> > > > --- a/include/linux/pkeys.h
> > > > +++ b/include/linux/pkeys.h
> > > > @@ -50,4 +50,28 @@ static inline void copy_init_pkru_to_fpregs(void)
> > > >  
> > > >  #endif /* ! CONFIG_ARCH_HAS_PKEYS */
> > > >  
> > > > +#define PKS_FLAG_EXCLUSIVE 0x00
> > > > +
> > > > +#ifndef CONFIG_ARCH_HAS_SUPERVISOR_PKEYS
> > > > +static inline int pks_key_alloc(const char * const pkey_user, int flags)
> > > > +{
> > > > +	return -EOPNOTSUPP;
> > > > +}
> > > > +static inline void pks_key_free(int pkey)
> > > > +{
> > > > +}
> > > > +static inline void pks_mk_noaccess(int pkey)
> > > > +{
> > > > +	WARN_ON_ONCE(1);
> > > 
> > > So for panic-on-warn systems, this is ok to reboot the box?
> > 
> > I would not expect this to reboot the box no.  But it is a violation of the API
> > contract.  If pky_key_alloc() returns an error calling any of the other
> > functions is an error.
> > 
> > > 
> > > Are you sure, that feels odd...
> > 
> > It does feel odd and downright wrong...  But there are a lot of WARN_ON_ONCE's
> > out there to catch this type of internal programming error.  Is panic-on-warn
> > commonly used?
> 
> Yes it is, and we are trying to recover from that as it is something
> that you should recover from.  Properly handle the error and move on.

Sorry, I did not know that...  Ok I'll look at the series because I probably
have others I need to change.

Thanks,
Ira
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
