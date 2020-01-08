Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B3996133898
	for <lists+linux-nvdimm@lfdr.de>; Wed,  8 Jan 2020 02:39:44 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 3140110097DA3;
	Tue,  7 Jan 2020 17:43:02 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::341; helo=mail-ot1-x341.google.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mail-ot1-x341.google.com (mail-ot1-x341.google.com [IPv6:2607:f8b0:4864:20::341])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 71AD510097E1B
	for <linux-nvdimm@lists.01.org>; Tue,  7 Jan 2020 17:42:59 -0800 (PST)
Received: by mail-ot1-x341.google.com with SMTP id r9so1977443otp.13
        for <linux-nvdimm@lists.01.org>; Tue, 07 Jan 2020 17:39:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/d9k45/z7659u+xtEjN+MYx3Q6GpIJRf/rpR3Gk/DdU=;
        b=YgTkFvh6k7M6dHhTjbBTUDG+NIIUI6w5fWZZA+SRtfvALbUkv5kvWYonJKu3sSN8bN
         b+37/Q5KLz31UR0SYudLvDmy3JK9UFCkDIiMhXQQj3dHQVUjo9J9ywjL/XUPmwYswP+/
         xeZnbYsjQkynkvVrvx19nSACawRXUpVW3q/vIubfYBFV7v5sMRYWA0QCbBX53/Lh0Y7W
         ilS3gDYmvch66jqOGL1GQp/MCtciI6dWOmQeI8tXQSnJmFLQE2FOeA4lxSiGMCYIgXRf
         1q2zJd9/QHTXMPJFdyvYajbTtvIkBgU7ptveduecznGjcWJeA/35nNkhH+y9tInkFeK1
         ra9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/d9k45/z7659u+xtEjN+MYx3Q6GpIJRf/rpR3Gk/DdU=;
        b=CmyfFxbu+b98eZOgoefU4XTzIdZGlHAc93GnX6PgrDbSq2hJUEeSq73pR4bUPAVWa0
         rIdsEWPDHkXkj/sRuk+H8/Cao/dP+Pf2psJskzvmJDb90Tihw98GeRPiNDfq1UbQhTrH
         RrWNW7MqfUch5YxM5V91id/NsW9qXTfsuF7Y3UOYRt8T3CeUOLOtOt2eVs7SeNYvx3OM
         0CvHtt/GUMkxE4obkjf83nfehCpU6eygQFlQzYiYJWfCykgBHNslrCnL0b7UAg0OXk8l
         cFSP3yg1K+oGttvvfCk9tj9RUXONyVn8pg60SMiikLUzNfed/tYXlZjuhgxKc59eSkPf
         X58Q==
X-Gm-Message-State: APjAAAVftJ5mFO8TAjxzK7AD2/mL/DutfN2bX38twhD0mP40GPFsSdnk
	ShyWEBwvoyETG6qmI+RaXbwcDhRGj/Az1qYc8T6Iog==
X-Google-Smtp-Source: APXvYqxdf0Bo2pMJ9s40oQqu9673Krm3/AIHd7ihdu+tmuZao9+mHEVhrRD0TY+1uOwKKPxbusMCMUEGKxcHJtyvZxo=
X-Received: by 2002:a9d:68cc:: with SMTP id i12mr2328311oto.207.1578447579439;
 Tue, 07 Jan 2020 17:39:39 -0800 (PST)
MIME-Version: 1.0
References: <20191212182238.46535-1-brho@google.com> <20191212182238.46535-3-brho@google.com>
 <06108004-1720-41EB-BCAB-BFA8FEBF4772@oracle.com> <ED482280-CB47-4AB6-9E7E-EEE7848E0F8B@oracle.com>
 <f8e948ff-6a2a-a6d6-9d8e-92b93003354a@google.com> <65FB6CC1-3AD2-4D6F-9481-500BD7037203@oracle.com>
 <20191213171950.GA31552@linux.intel.com> <e012696f-f13e-5af1-2b14-084607d69bfa@google.com>
 <20200107190522.GA16987@linux.intel.com> <08a36944-ad5a-ca49-99b3-d3908ce0658b@google.com>
 <20200108012014.GF16987@linux.intel.com>
In-Reply-To: <20200108012014.GF16987@linux.intel.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Tue, 7 Jan 2020 17:39:28 -0800
Message-ID: <CAPcyv4jW3HTU7mmctL_d+zTS8yT_NLxa5cx_w8nbqVSwBMdSLQ@mail.gmail.com>
Subject: Re: [PATCH v5 2/2] kvm: Use huge pages for DAX-backed files
To: Sean Christopherson <sean.j.christopherson@intel.com>
Message-ID-Hash: B4LD2FOSQK54RFJPOMW6AWKBYDPFGRVN
X-Message-ID-Hash: B4LD2FOSQK54RFJPOMW6AWKBYDPFGRVN
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: Barret Rhoden <brho@google.com>, Liran Alon <liran.alon@oracle.com>, Paolo Bonzini <pbonzini@redhat.com>, David Hildenbrand <david@redhat.com>, Alexander Duyck <alexander.h.duyck@linux.intel.com>, linux-nvdimm <linux-nvdimm@lists.01.org>, X86 ML <x86@kernel.org>, KVM list <kvm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "Zeng, Jason" <jason.zeng@intel.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/B4LD2FOSQK54RFJPOMW6AWKBYDPFGRVN/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Tue, Jan 7, 2020 at 5:20 PM Sean Christopherson
<sean.j.christopherson@intel.com> wrote:
>
> On Tue, Jan 07, 2020 at 02:19:06PM -0500, Barret Rhoden wrote:
> > On 1/7/20 2:05 PM, Sean Christopherson wrote:
> > >Hopefully you haven't put too much effort into the rework, because I want
> > >to commandeer the proposed changes and use them as the basis for a more
> > >aggressive overhaul of KVM's hugepage handling.  Ironically, there's a bug
> > >in KVM's THP handling that I _think_ can be avoided by using the DAX
> > >approach of walking the host PTEs.
> > >
> > >I'm in the process of testing, hopefully I'll get a series sent out later
> > >today.  If not, I should at least be able to provide an update.
> >
> > Nice timing.  I was just about to get back to this, so I haven't put any
> > time in yet.  =)
> >
> > Please CC me, and I'll try your patches out on my end.
>
> Will do.  Barring last minute hiccups, the code is ready, just need to
> finish off a few changelogs.  Should get it out early tomorrow.
>
> One question that may help avoid some churn: are huge DAX pages not
> tracked as compound pages?  The comment from your/this patch is pretty
> unequivocal, but I wanted to double check that they will really return
> false for PageCompound(), as opposed to only returning false for
> PageTransCompoundMap().

PageCompound() returns false.

>
>         /*
>          * DAX pages do not use compound pages.  ...
>          */
>

None of the head / tail page infrastructure is set up for dax pages.
They are just independent 'struct page' objects that are
opportunistically mapped by different pte sizes in the dax core.
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
