Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 25C292B89F9
	for <lists+linux-nvdimm@lfdr.de>; Thu, 19 Nov 2020 03:06:53 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id C65AE100EBB7D;
	Wed, 18 Nov 2020 18:06:51 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::f43; helo=mail-qv1-xf43.google.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mail-qv1-xf43.google.com (mail-qv1-xf43.google.com [IPv6:2607:f8b0:4864:20::f43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id A1B11100EBB7B
	for <linux-nvdimm@lists.01.org>; Wed, 18 Nov 2020 18:06:42 -0800 (PST)
Received: by mail-qv1-xf43.google.com with SMTP id v20so2141247qvx.4
        for <linux-nvdimm@lists.01.org>; Wed, 18 Nov 2020 18:06:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ccKfW56H4PWGLSjC0LsiNJcR0/vxH+yLXhxLYv0fM10=;
        b=rDU5+I6pfV/cpFPoCHYruTKxc1OUpArWLHBTpwX44EnsntWdNP7pLL/ebBoZsoVGbY
         GyztbDlk2ndtd0rZMuLsmToFvj8GlD22ytPS6vj0lUmZzKsMBJmtQtkDkgX6dSgJy4WS
         xuLb/McJwAMWVFy49HaLh43LP4vJsl+12KJR4uOPU77WJ7+I5lzrIyPfoKtYBwuot25v
         NsSO+Sobt2TJqCTfzPXEXOxcpUHp9wIuVbBzCDm/yA6mG+rHPriYmof9pH6e8F2g3N3S
         wymqm+Og5mCuxNOU9X7ZohZ0mPgRSMnjnsvcovxrsUGR2Q1yxgwujG+wfwT4EDxIjqPo
         WoKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ccKfW56H4PWGLSjC0LsiNJcR0/vxH+yLXhxLYv0fM10=;
        b=OSfTb/f2Jnav8y6lWU2SbAgYPz5qr70uKI9I5sXeRLhbBJfpUZSDIGEieBaANhAQxO
         vXt4NUmbNlw28OVpWN8ile8WjDguLm3gZpn0RDymHWNgm7/3Vvz6pyp6O8MJSiMsso8o
         Kex0E/RXH0/DcLObahkrrvtpBMSw+a4OA3HIzu9cKsFPs3CcQaJt7ez+U2caF6ir40ff
         HcU5EcqwAj8JoyFkX59MbZ/iUuJ21BWh0eRKQ6DcQOAbvajUswwTd6MYX2AwAUAn5+Jp
         ulPcBCgjAH/1j4tMKscehW6/d2FGnDoe21AafzaV7BlA2JBf679D1alFfNgYIlzCNvst
         Fmbg==
X-Gm-Message-State: AOAM532QDuHAo3Sfc4NXPbkl0LTsYj80LjcyaqcqbJuk4CjgZmQ+Ztac
	4p6tLA+79OsX2g6RYfInQfc7FQbooEJN9dRINUSmwQ==
X-Google-Smtp-Source: ABdhPJydAOOGYkEH//Rv4uY6EQ0za+qOAE0menANWzPkoy7vb2aGs+AHfwWpmp2vsHVsLEFb3E3oYqrsw6jHynE16DU=
X-Received: by 2002:a0c:e8c8:: with SMTP id m8mr8228752qvo.41.1605751601185;
 Wed, 18 Nov 2020 18:06:41 -0800 (PST)
MIME-Version: 1.0
References: <20201118084117.1937-1-thunder.leizhen@huawei.com>
 <9b8310ed-e93f-e708-eefa-520701e6d044@huawei.com> <CAPcyv4hc0bw=+HQ-Zj0AWfB2-xMEEC--64zNxBkyapkiQRVVdg@mail.gmail.com>
 <390a0fb5-5feb-527c-b90e-1c7b6ea65d5f@huawei.com>
In-Reply-To: <390a0fb5-5feb-527c-b90e-1c7b6ea65d5f@huawei.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Wed, 18 Nov 2020 18:06:30 -0800
Message-ID: <CAPcyv4h0To2N1QrofE6qddeuQPBH3Umh9e+emBv-Nej4gS4V+g@mail.gmail.com>
Subject: Re: [PATCH 1/1] ACPI/nfit: correct the badrange to be reported in nfit_handle_mce()
To: "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Message-ID-Hash: XNG2BB4D5V473UK2VJRAKU4C2T4NYSVT
X-Message-ID-Hash: XNG2BB4D5V473UK2VJRAKU4C2T4NYSVT
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: "Rafael J . Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, linux-nvdimm <linux-nvdimm@lists.01.org>, linux-acpi <linux-acpi@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/XNG2BB4D5V473UK2VJRAKU4C2T4NYSVT/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Wed, Nov 18, 2020 at 5:53 PM Leizhen (ThunderTown)
<thunder.leizhen@huawei.com> wrote:
>
>
>
> On 2020/11/19 3:16, Dan Williams wrote:
> > On Wed, Nov 18, 2020 at 12:55 AM Leizhen (ThunderTown)
> > <thunder.leizhen@huawei.com> wrote:
> >>
> >>
> >>
> >> On 2020/11/18 16:41, Zhen Lei wrote:
> >>> The badrange to be reported should always cover mce->addr.
> >> Maybe I should change this description to:
> >> Make sure the badrange to be reported can always cover mce->addr.
> >
> > Yes, I like that better. Can you also say a bit more about how you
> > found this bug? As far as I can see this looks like -stable material.
>
> I found it when I was learning the code. I'm looking at it carefully.

Ok, good eye.

The impact of this one is somewhat mitigated by the fact that errors
are expanded to 512 byte blast radius, and error consumption maps 4k
around errors. I suspect few are trying to use the badblock list to do
fine grained recovery so this bug went unnoticed.
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
