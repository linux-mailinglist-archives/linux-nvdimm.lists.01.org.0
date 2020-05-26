Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 34B211E302D
	for <lists+linux-nvdimm@lfdr.de>; Tue, 26 May 2020 22:43:03 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 7A87112233835;
	Tue, 26 May 2020 13:38:54 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:20::642; helo=mail-ej1-x642.google.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 07C4B12233833
	for <linux-nvdimm@lists.01.org>; Tue, 26 May 2020 13:38:51 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id h21so25305895ejq.5
        for <linux-nvdimm@lists.01.org>; Tue, 26 May 2020 13:42:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=z0+qB9PAs/0dIVTxt6TWQveY0BQoV0IqGxgJ1RJtPJ8=;
        b=Mmipay1v52TsRSAxngafTq/GIafI4i5MGesqoQtqIdctmq2XigRTUluiaR0xV89H8W
         yFzbwIKrBLUxF4eDbHG0as3sOfpOM83xGs601y887zEJjHAiHDF7VT6KQkB4JHQjB+na
         TnG/+HHbvltKPGgCYphiAK/76TjA7NPgX/90rpvU+U/H03TfX3bVQeczDzuRzvsb3Urj
         g9+bv6Z2MMCzThJPGN1avuSRTdBz98RNNdENoNfvHGiE7NT4k8XFpDXzQXR5lr0Aw2Cf
         OWr9AK5ECVGOcCcBmi9DJ1IEHOE9haHRMJQeACqeeazF80DGfUucWYS/YVdlDlpVhS6j
         aQUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=z0+qB9PAs/0dIVTxt6TWQveY0BQoV0IqGxgJ1RJtPJ8=;
        b=rUVWPVhO5EjozGze1JfWXDvhmRGRvpqoWSvXNvjuizTkWlwA4C1A+Efy/pVmANaPO6
         jLBGWO8y010ms6JmUvlWH15DweNqmzXjrtghed+Kibufgk+9g5RiMAAoqca14ehQkH+D
         lwgaGqTmepsK+z82Vg9NJ41J3hJBbkDtuX2IkiPsq040SBw3LDNl560dzUDEfSzWecVb
         yTJt8ApmnRpmPyz7PmluixD6dc+th3MQBxGl5pAk8Rldt2nvYZh4iDH4WycnYRwecvLy
         cRjiYHYrD4nf/lZhQM2sf3le7gZbxsm/srqd5QAv6rxquOhBBFSYqYdaZTw3A7eEYJLW
         EeHA==
X-Gm-Message-State: AOAM5327CdWLlkHABGpCkQxoJfOtBjrF+k/XIrgMgOY3gT2LROzDQXR/
	fIx4hZ8eds9iPTMdqgcS4bXAuo6NBzam1JGTjR86KA==
X-Google-Smtp-Source: ABdhPJyjICkIAYJoUWeh5IAj7h4qSUa1lPDgHsaGCVWa7SWsoVWAuaVyTS5T07gQoCLsNSWBDtrrXAQew17WRC/6Zf4=
X-Received: by 2002:a17:906:3597:: with SMTP id o23mr2695842ejb.174.1590525775277;
 Tue, 26 May 2020 13:42:55 -0700 (PDT)
MIME-Version: 1.0
References: <159010426294.1062454.8853083370975871627.stgit@dwillia2-desk3.amr.corp.intel.com>
 <20200522115800.GA1451824@kroah.com> <20200522120009.GA1456052@kroah.com>
In-Reply-To: <20200522120009.GA1456052@kroah.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Tue, 26 May 2020 13:42:44 -0700
Message-ID: <CAPcyv4jW9P2FP2p6OiLoN+e_wzZY9-c8C-mMMoDqohuTekF7WQ@mail.gmail.com>
Subject: Re: [5.4-stable PATCH 0/7] libnvdimm: Cross-arch compatible namespace alignment
To: Greg KH <gregkh@linuxfoundation.org>
Message-ID-Hash: E2X3GLQREZA5EKXMN6D5YLJQFQ7MB5Q7
X-Message-ID-Hash: E2X3GLQREZA5EKXMN6D5YLJQFQ7MB5Q7
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: stable <stable@vger.kernel.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Michael Ellerman <mpe@ellerman.id.au>, Paul Mackerras <paulus@samba.org>, Christoph Hellwig <hch@lst.de>, "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>, linux-nvdimm <linux-nvdimm@lists.01.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/E2X3GLQREZA5EKXMN6D5YLJQFQ7MB5Q7/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Fri, May 22, 2020 at 5:00 AM Greg KH <gregkh@linuxfoundation.org> wrote:
>
> On Fri, May 22, 2020 at 01:58:00PM +0200, Greg KH wrote:
> > On Thu, May 21, 2020 at 04:37:43PM -0700, Dan Williams wrote:
> > > Hello stable team,
> > >
> > > These patches have been shipping in mainline since v5.7-rc1 with no
> > > reported issues. They address long standing problems in libnvdimm's
> > > handling of namespace provisioning relative to alignment constraints
> > > including crashes trying to even load the driver on some PowerPC
> > > configurations.
> > >
> > > I did fold one build fix [1] into "libnvdimm/region: Introduce an 'align'
> > > attribute" so as to not convey the bisection breakage to -stable.
> > >
> > > Please consider them for v5.4-stable. They do pass the latest
> > > version of the ndctl unit tests.
> >
> > What about 5.6.y?  Any user upgrading from 5.4-stable to 5.6-stable
> > would hit a regression, right?
> >
> > So can we get a series backported to 5.6.y as well?  I need that before
> > I can take this series.

Yes, should be the exact same set, but I will run the regression suite
to be sure.

> Also, I really don't see the "bug" that this is fixing here.  If this
> didn't work on PowerPC before, it can continue to just "not work" until
> 5.7, right?

There's a mix of "never worked" and "used to work" in this set. The
PowerPC case is indeed a "never worked", but I highlighted it as it
was the simplest to understand.

> What problems with 5.4.y and 5.6.y is this series fixing
> that used to work before?

The "used to work" bug fixed by this set is the fact that the kernel
used to force a 128MB (memory hotplug section size) alignment padding
on all persistent memory namespaces to enable DAX operation. The
support for sub-sections (2MB) dropped forced alignment padding, but
unfortunately introduced a regression for the case of trying to create
multiple unaligned namespaces. When that bug triggers namespace
creation for the region is disabled, iirc, previously that lockout
scenario was prevented.

Jeff, can you corroborate this?

I otherwise agree, if the above never worked then this can all wait
for v5.7 upgrades.
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
