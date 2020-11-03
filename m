Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 857A62A4E0E
	for <lists+linux-nvdimm@lfdr.de>; Tue,  3 Nov 2020 19:14:16 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id E34C31647BD1F;
	Tue,  3 Nov 2020 10:14:14 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=198.145.29.99; helo=mail.kernel.org; envelope-from=gregkh@linuxfoundation.org; receiver=<UNKNOWN> 
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 0E98B1647BD1F
	for <linux-nvdimm@lists.01.org>; Tue,  3 Nov 2020 10:14:12 -0800 (PST)
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPSA id A35C720780;
	Tue,  3 Nov 2020 18:14:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1604427252;
	bh=xcmtesgScEThQWVAlyFHd721UIZTZBM+vfZNEw5TWHw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VimesJGlvik33xmtNnlRSxLtCoeagRnzi3P48Mt4udCeWae8MrB7kbLbSumPf5F15
	 Ku982wT3xj9JAYwm4Ol3n+M9OgWO5KrFlHYhIod0StZ0pIG7z+e+jY0wUOJ/cHUyho
	 JVeirJgujY0qEwRZE13TH1EGI5f/uLoc09DA1ca4=
Date: Tue, 3 Nov 2020 19:14:07 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Ira Weiny <ira.weiny@intel.com>
Subject: Re: [PATCH V2 05/10] x86/pks: Add PKS kernel API
Message-ID: <20201103181407.GA83845@kroah.com>
References: <20201102205320.1458656-1-ira.weiny@intel.com>
 <20201102205320.1458656-6-ira.weiny@intel.com>
 <20201103065024.GC75930@kroah.com>
 <20201103175335.GA1531489@iweiny-DESK2.sc.intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20201103175335.GA1531489@iweiny-DESK2.sc.intel.com>
Message-ID-Hash: WNLZ5KOWIQXWPKDQQCGAM2HZACENT6J3
X-Message-ID-Hash: WNLZ5KOWIQXWPKDQQCGAM2HZACENT6J3
X-MailFrom: gregkh@linuxfoundation.org
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Dave Hansen <dave.hansen@linux.intel.com>, Fenghua Yu <fenghua.yu@intel.com>, x86@kernel.org, Andrew Morton <akpm@linux-foundation.org>, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-nvdimm@lists.01.org, linux-mm@kvack.org, linux-kselftest@vger.kernel.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/WNLZ5KOWIQXWPKDQQCGAM2HZACENT6J3/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Tue, Nov 03, 2020 at 09:53:36AM -0800, Ira Weiny wrote:
> On Tue, Nov 03, 2020 at 07:50:24AM +0100, Greg KH wrote:
> > On Mon, Nov 02, 2020 at 12:53:15PM -0800, ira.weiny@intel.com wrote:
> > > From: Fenghua Yu <fenghua.yu@intel.com>
> > > 
> 
> [snip]
> 
> > > diff --git a/include/linux/pkeys.h b/include/linux/pkeys.h
> > > index 2955ba976048..0959a4c0ca64 100644
> > > --- a/include/linux/pkeys.h
> > > +++ b/include/linux/pkeys.h
> > > @@ -50,4 +50,28 @@ static inline void copy_init_pkru_to_fpregs(void)
> > >  
> > >  #endif /* ! CONFIG_ARCH_HAS_PKEYS */
> > >  
> > > +#define PKS_FLAG_EXCLUSIVE 0x00
> > > +
> > > +#ifndef CONFIG_ARCH_HAS_SUPERVISOR_PKEYS
> > > +static inline int pks_key_alloc(const char * const pkey_user, int flags)
> > > +{
> > > +	return -EOPNOTSUPP;
> > > +}
> > > +static inline void pks_key_free(int pkey)
> > > +{
> > > +}
> > > +static inline void pks_mk_noaccess(int pkey)
> > > +{
> > > +	WARN_ON_ONCE(1);
> > 
> > So for panic-on-warn systems, this is ok to reboot the box?
> 
> I would not expect this to reboot the box no.  But it is a violation of the API
> contract.  If pky_key_alloc() returns an error calling any of the other
> functions is an error.
> 
> > 
> > Are you sure, that feels odd...
> 
> It does feel odd and downright wrong...  But there are a lot of WARN_ON_ONCE's
> out there to catch this type of internal programming error.  Is panic-on-warn
> commonly used?

Yes it is, and we are trying to recover from that as it is something
that you should recover from.  Properly handle the error and move on.

thanks,

greg k-h
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
