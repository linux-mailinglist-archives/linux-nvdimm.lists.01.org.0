Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 87FC9362ACF
	for <lists+linux-nvdimm@lfdr.de>; Sat, 17 Apr 2021 00:09:56 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id CA97F100EAAE3;
	Fri, 16 Apr 2021 15:09:54 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=209.85.222.181; helo=mail-qk1-f181.google.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id C1293100F2274
	for <linux-nvdimm@lists.01.org>; Fri, 16 Apr 2021 15:09:51 -0700 (PDT)
Received: by mail-qk1-f181.google.com with SMTP id q136so9531275qka.7
        for <linux-nvdimm@lists.01.org>; Fri, 16 Apr 2021 15:09:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CAVpyw3HpD2ywqcxbGBN3eCbLgjjSxQTSq6wSel4TrA=;
        b=mgiKr04WpGHHyDIWIGaT65rHJ9jD/JD/Uj/YlXXR8MG6IiATka2xsfIt9xHBTV3vih
         H5OXJBDQR0rosJ8fxSnbgnHWn1KmDRKcOgiFb3Q7QF/e1ZO21n0Xm/MW0mrmHfr21VG0
         5INdlCVkP4UShi8ay7i4T9LWESpN5T5cGpBAgNEuTxY+Vqb19g8KFDavGOgGp6S6XcbE
         Q0AXEhJEyrNfrIyOl7kVh+uOgctitCNdnii/viwOOWe2+2mYqDexF3XLo3/0KnNak75A
         g3QQUi8Gx4CL1qDpHqIEStBRhHp1sRU0Nb9b60mMVMsUqEUZQBuPOG74d3USuK9LJcRs
         N09Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CAVpyw3HpD2ywqcxbGBN3eCbLgjjSxQTSq6wSel4TrA=;
        b=GTb7Armh28vQjaUU0OoL9yW2t1NiTyBas0Q9oENw3gdxJo5NTQdF/9NeNJfoY1cnJ8
         rZfJ6FPFQLw7z1krb6UzWrhvJInYTx+f9zeNquuYUAAwiClgsYQfbczeMwnmInuIG0qw
         UfY2JGzWcVJR1POeD2S2Tg6Ty62qP2JikLzWLp3TWUyu+AjPRzSaFOHXjzQLQQxxJZxq
         +M67jLSyXge6LG4p+zTQBawR3TE8dLh9AcTHO0xdSKgLpZ59KPQoUKDZF/vNUdS8yrrZ
         LwY9F3U1M+E3vcMjO0WKsGjkPCSRwwrtGXC9pczNlK1i8QAf05bHsPKTBVGHOblLgqcy
         tntA==
X-Gm-Message-State: AOAM533g9IIEj596qBUJtmOBD+I4UKBpyoDWk3VvcXuWT3xOU697aXoZ
	5RdRhavgmGQlQV/Q1Sb5OONe3xJet8nPI4ycNKNMyCcA/gY=
X-Google-Smtp-Source: ABdhPJwgecDMzKX0rqVmFwlWXvMyRxsyDDfr45Z81oJcuJNaPT9jTWQ10/rnHymH7M+5L6PQ1WCkqUIZJmrAR+B/N+I=
X-Received: by 2002:a05:620a:3d9:: with SMTP id r25mr1417902qkm.421.1618610930841;
 Fri, 16 Apr 2021 15:08:50 -0700 (PDT)
MIME-Version: 1.0
References: <20210415143754.16553-1-andriy.shevchenko@linux.intel.com>
 <YHnLCoeBDn3BcRx1@smile.fi.intel.com> <CAPcyv4iwiJwwgiisZTqk6F=A8hLJCGkK-4suqDMPYYiLzuLwFA@mail.gmail.com>
 <YHn2oiP+2YpkFGXQ@smile.fi.intel.com>
In-Reply-To: <YHn2oiP+2YpkFGXQ@smile.fi.intel.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Fri, 16 Apr 2021 15:08:40 -0700
Message-ID: <CAPcyv4g=XyFfDZYL-brAO7LTVEc90=x7aQWar_WZtfnPx09UVQ@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] libnvdimm: Don't use GUID APIs against raw buffer
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Message-ID-Hash: XBPON3OR4ZTOTY5KPTGVQF24Q7O2PG4I
X-Message-ID-Hash: XBPON3OR4ZTOTY5KPTGVQF24Q7O2PG4I
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: linux-nvdimm <linux-nvdimm@lists.01.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "Kaneda, Erik" <erik.kaneda@intel.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/XBPON3OR4ZTOTY5KPTGVQF24Q7O2PG4I/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Fri, Apr 16, 2021 at 1:42 PM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Fri, Apr 16, 2021 at 01:08:06PM -0700, Dan Williams wrote:
> > [ add Erik ]
> >
> > On Fri, Apr 16, 2021 at 10:36 AM Andy Shevchenko
> > <andriy.shevchenko@linux.intel.com> wrote:
> > >
> > > On Thu, Apr 15, 2021 at 05:37:54PM +0300, Andy Shevchenko wrote:
> > > > Strictly speaking the comparison between guid_t and raw buffer
> > > > is not correct. Return to plain memcmp() since the data structures
> > > > haven't changed to use uuid_t / guid_t the current state of affairs
> > > > is inconsistent. Either it should be changed altogether or left
> > > > as is.
> > >
> > > Dan, please review this one as well. I think here you may agree with me.
> >
> > You know, this is all a problem because ACPICA is using a raw buffer.
>
> And this is fine. It might be any other representation as well.
>
> > Erik, would it be possible to use the guid_t type in ACPICA? That
> > would allow NFIT to drop some ugly casts.
>
> guid_t is internal kernel type. If we ever decide to deviate from the current
> representation it wouldn't be possible in case a 3rd party is using it 1:1
> (via typedef or so).

I'm thinking something like ACPICA defining that space as a union with
the correct typing just for Linux.
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
