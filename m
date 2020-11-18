Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DCBFA2B8483
	for <lists+linux-nvdimm@lfdr.de>; Wed, 18 Nov 2020 20:17:16 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 1BDC5100EBB68;
	Wed, 18 Nov 2020 11:17:15 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:20::641; helo=mail-ej1-x641.google.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 9D49C100EC1F2
	for <linux-nvdimm@lists.01.org>; Wed, 18 Nov 2020 11:17:12 -0800 (PST)
Received: by mail-ej1-x641.google.com with SMTP id i19so4331396ejx.9
        for <linux-nvdimm@lists.01.org>; Wed, 18 Nov 2020 11:17:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=81PlRLP0p2YmMe4H5uWqNhtURGW1y1XdOZLIO5F9YLc=;
        b=IEmV9qoEH+VLpoYyNzawjBU3gJvxj8OcypC3VnxKE5lxNmuD+wiOJCRCW+/QUlkc14
         +In7+KyScQJ2+u99Bg5waJ/8B9TXdZB1YBsHDuWTYKobjPNVfmVgxLs/ix+1YdkaF7RZ
         8J5RjPK7huvShsX6yV+DYRlaioR55ExxT1IjTvdGSv9HTEzDg0WikN6WBtCO3IYfk+PE
         spu678zJdUE5jBpeN1VpR6a9niGLPcQnW7jO86kg/DITRrbRRdNQczR478OTtDF3850l
         thoFHoHCoSUtduio/nxfyPLyxJ+cVBG/NA2QMrsvIMIb3/rmDPC56fsQVUKcRxW5RZh1
         reXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=81PlRLP0p2YmMe4H5uWqNhtURGW1y1XdOZLIO5F9YLc=;
        b=JuYoz0yNNxGfMVBG/xcbs+6pWMxVr6StvjU7nahjO7fcaWFkmSPphNs0bItLBvHA0+
         IWYg8gpWLMoef9uDy6A3ctbcZxrnsnEZ08fxe7k9qEs2ydFjT8IQSXQTBHrro0Xc9WVL
         fwQtIsEc8mRmpvILPNKrVe/iT8aWrzHj6YbpD2xG7NGqKp6XasBf6a8CaQbZ2tIrNkh8
         jFhDoFv5Z0obK71mOclIvQOgl/gYpk+AR5WT8sB+947RrDi3Hdzy20VJtNYsjmALJCr0
         ezQ4RqYAPnSsoXTCiqQcsIrKzRcgPUmCXhO4F5+dMVmdaXKZ0RO5mL/7Ag9Un8usrqm8
         e6Wg==
X-Gm-Message-State: AOAM5303qq2SY59FvbRV19QK3R+0NdlY8sVPF+dBNNf98HUNfSBqdlrj
	ILNY3n2fXWk5dZS3IamS8N1RfNB6a62wvLWfCkEg6A==
X-Google-Smtp-Source: ABdhPJwvNVfgBGELqNuL/n59F+v052BHnvvJO98npzqht+NZtcKSmy214B4JUAm0W8adcIQwvB6JKQnKtNN/1ytPB/0=
X-Received: by 2002:a17:906:914d:: with SMTP id y13mr13924322ejw.45.1605727030657;
 Wed, 18 Nov 2020 11:17:10 -0800 (PST)
MIME-Version: 1.0
References: <20201118084117.1937-1-thunder.leizhen@huawei.com> <9b8310ed-e93f-e708-eefa-520701e6d044@huawei.com>
In-Reply-To: <9b8310ed-e93f-e708-eefa-520701e6d044@huawei.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Wed, 18 Nov 2020 11:16:59 -0800
Message-ID: <CAPcyv4hc0bw=+HQ-Zj0AWfB2-xMEEC--64zNxBkyapkiQRVVdg@mail.gmail.com>
Subject: Re: [PATCH 1/1] ACPI/nfit: correct the badrange to be reported in nfit_handle_mce()
To: "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Message-ID-Hash: TD75NKSMJFW4UME2KEXXUAGBYAYUNM4I
X-Message-ID-Hash: TD75NKSMJFW4UME2KEXXUAGBYAYUNM4I
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: "Rafael J . Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, linux-nvdimm <linux-nvdimm@lists.01.org>, linux-acpi <linux-acpi@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/TD75NKSMJFW4UME2KEXXUAGBYAYUNM4I/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Wed, Nov 18, 2020 at 12:55 AM Leizhen (ThunderTown)
<thunder.leizhen@huawei.com> wrote:
>
>
>
> On 2020/11/18 16:41, Zhen Lei wrote:
> > The badrange to be reported should always cover mce->addr.
> Maybe I should change this description to:
> Make sure the badrange to be reported can always cover mce->addr.

Yes, I like that better. Can you also say a bit more about how you
found this bug? As far as I can see this looks like -stable material.
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
