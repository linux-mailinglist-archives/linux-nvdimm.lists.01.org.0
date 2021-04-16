Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C815E36290F
	for <lists+linux-nvdimm@lfdr.de>; Fri, 16 Apr 2021 22:09:21 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 0B82F100EAB7C;
	Fri, 16 Apr 2021 13:09:20 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=209.85.218.52; helo=mail-ej1-f52.google.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id E55E7100EAB7B
	for <linux-nvdimm@lists.01.org>; Fri, 16 Apr 2021 13:09:17 -0700 (PDT)
Received: by mail-ej1-f52.google.com with SMTP id v6so42540877ejo.6
        for <linux-nvdimm@lists.01.org>; Fri, 16 Apr 2021 13:09:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=z/7RWfCnT+MFSVYzAj6rhZv/Tp/5lHV7PIZVXaikxkA=;
        b=TgBtkKhTKA/3SO+uKkjRq5/DlYpoEltcTRr/ImpSWzE3QS2RpSo2qNzUXnGLTWKx5j
         +BCpYvYl1lU1xiocJDtfK5t8hacvcJbVhYhi7bRPPO3Gv9/8fUmOYV8Hn/m11Zh8M2b3
         V/SY4P4YrIAvVa/3bmH+XrxlSrOGHYv3+1VfA/7eAwBawvXf/o5djAsP34AuffTpSEF9
         YwqXst09X24mWgfR+xyQZbbWroVHZ8+A8VGVqEHz59RX9atw6F6tdOLuqTLstQ2lgZz8
         2gmDCCOfKeWJxZrTK+R5XDUncpuMfrZnnoxiu7edHVr3nSFpwcUSmxhWV121Pyhd+aXE
         e6WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=z/7RWfCnT+MFSVYzAj6rhZv/Tp/5lHV7PIZVXaikxkA=;
        b=tHSQEK9HcLkeR0tpP7TGKmhyeyystkz6E4zAmzMKjpSF4FO+WM4vfdn5G9HCHk7eed
         Hh/6PB/Kh7IDUnYHhOWQxCLo9yWpEKgIyGr0m50mK0VVFPl3CSR0mE2B3Sfmj+3Uk6HQ
         Uj+NVO2hlC1w8rZLUvM9237ThD62MvDp9RpNDGpMoIGgIx1nMvCoxEbVnFcDA0V2BZ0g
         B3cFmqT3qiSX6P8h0nRvd5yCaLbq5dShf3r9t80Rmj+vKXeb1gf5gE9Mn8+bmc82MLvL
         r8lt1AWkcMcS1zk1D6bPi6ylT4qQebYlv5NBXAQejCAwjY0xihlLTTHomkXHqAdNuGaY
         Ncgw==
X-Gm-Message-State: AOAM531TzKXGb4KZLcYaR/uTGsLl2XuaPHF5/HYagGdQ4IA31TPQiNL1
	XbdQc6KQwU6KG11h3GPev5H7sIUpWu79unuPTWOwkQ==
X-Google-Smtp-Source: ABdhPJxLbYFLHe3hs9wcNWM4Ah9JtxOJIsqYpHQn3AKLBkjhJfWEajDnBKN3ne+6r6z2JZwn9ZUv8rMczHUp+Op2Ljc=
X-Received: by 2002:a17:907:7631:: with SMTP id jy17mr9998196ejc.418.1618603696603;
 Fri, 16 Apr 2021 13:08:16 -0700 (PDT)
MIME-Version: 1.0
References: <20210415143754.16553-1-andriy.shevchenko@linux.intel.com> <YHnLCoeBDn3BcRx1@smile.fi.intel.com>
In-Reply-To: <YHnLCoeBDn3BcRx1@smile.fi.intel.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Fri, 16 Apr 2021 13:08:06 -0700
Message-ID: <CAPcyv4iwiJwwgiisZTqk6F=A8hLJCGkK-4suqDMPYYiLzuLwFA@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] libnvdimm: Don't use GUID APIs against raw buffer
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Message-ID-Hash: OEZJDXKFKDIZPNVZYIRR3TGXUS2LDBXU
X-Message-ID-Hash: OEZJDXKFKDIZPNVZYIRR3TGXUS2LDBXU
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: linux-nvdimm <linux-nvdimm@lists.01.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "Kaneda, Erik" <erik.kaneda@intel.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/OEZJDXKFKDIZPNVZYIRR3TGXUS2LDBXU/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

[ add Erik ]

On Fri, Apr 16, 2021 at 10:36 AM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Thu, Apr 15, 2021 at 05:37:54PM +0300, Andy Shevchenko wrote:
> > Strictly speaking the comparison between guid_t and raw buffer
> > is not correct. Return to plain memcmp() since the data structures
> > haven't changed to use uuid_t / guid_t the current state of affairs
> > is inconsistent. Either it should be changed altogether or left
> > as is.
>
> Dan, please review this one as well. I think here you may agree with me.

You know, this is all a problem because ACPICA is using a raw buffer.

Erik, would it be possible to use the guid_t type in ACPICA? That
would allow NFIT to drop some ugly casts.
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
