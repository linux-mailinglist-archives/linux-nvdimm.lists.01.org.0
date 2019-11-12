Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E2921F96D6
	for <lists+linux-nvdimm@lfdr.de>; Tue, 12 Nov 2019 18:15:33 +0100 (CET)
Received: from new-ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 2A1C4100DC418;
	Tue, 12 Nov 2019 09:17:17 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::341; helo=mail-ot1-x341.google.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mail-ot1-x341.google.com (mail-ot1-x341.google.com [IPv6:2607:f8b0:4864:20::341])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 100A2100DC415
	for <linux-nvdimm@lists.01.org>; Tue, 12 Nov 2019 09:17:14 -0800 (PST)
Received: by mail-ot1-x341.google.com with SMTP id d5so14989573otp.4
        for <linux-nvdimm@lists.01.org>; Tue, 12 Nov 2019 09:15:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JVzIXHrO764GfG4Qiqm8/IBriT7RsdH75hTLmp9BmRA=;
        b=BV3xxOHWbIQpFI5CB7uozaEEkwDC3lyWKTSTyPa4TC3Rd1nV/7MnrtvXeaQ1Zn/abG
         nhzwgNg+HMP/zc7thH3+NozpyQbz1ePQ/ASz5y+YgICE0CRqSZzdHbEDliWn//CnYMRu
         vHRCY+Y8CVfx8lHiYzbdQMlPFcMr0aCT+stJMsIb3zLNuQGMY/pTwW26u1A1i3C9XOW+
         nw+Nq64NnYGla6dF2P9v2y4kMFTef25LsJwSzbFUjnSsxuStNJXwc4PC154fjf3VfdPF
         5LsksQleIaBa3iFOcbqYVbhweUIDtdGWopLOAv0G/rosJkOeTyOR/j9fGyVuxi7E4yrJ
         BsoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JVzIXHrO764GfG4Qiqm8/IBriT7RsdH75hTLmp9BmRA=;
        b=umLgjJWwwLpFvT+2Jt99+q/+ghZJ2jWlVaqLqyjM3pcNXexQEfG9lTE0WI9di8ZWmC
         lNTMYa1wK1cy+D7dmysLu9g51EhzF4wzdeV2/a0fRFp0N8Zt2ecEWc1NdalqqfYcVwVM
         2vg/wRG/sSTZ/xkScN8WeACZ7DQPmHuwFlH0iA9Nm6LyqPEdbivfcI2O2NrF39OaUqs/
         G6s/+kpj7SEuzChWY6QaluP4Hy3n+idUs3BQ3Dj6gekhvZ1iLjHlatD3Y60wE48QqKVs
         Vox65w8hYctaKGfn3ONF7mSEiIxfg43FYGBxipg8eN0kRHdTt/odlzXx93VqBZb4Jw7B
         t2eA==
X-Gm-Message-State: APjAAAV0ioOd7QLZ0dDVBfdlrzmcaE3RR7y+4QbE/39kwazWioqn0tE3
	xX6h4e2Dnfgklb7T77jOug37GOMDlRxdxgz0TgHJLA==
X-Google-Smtp-Source: APXvYqxBWRXUbhgUeJAvflllA99xOkq97GoI6xicPLh5pWfFwhtbLObGxHb1Ub62atqTxWhI8Bsq8hQNoxBqMIRsSJw=
X-Received: by 2002:a9d:5f11:: with SMTP id f17mr4555105oti.207.1573578928797;
 Tue, 12 Nov 2019 09:15:28 -0800 (PST)
MIME-Version: 1.0
References: <MN2PR02MB63362F7B019844D94D243CE2A5770@MN2PR02MB6336.namprd02.prod.outlook.com>
In-Reply-To: <MN2PR02MB63362F7B019844D94D243CE2A5770@MN2PR02MB6336.namprd02.prod.outlook.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Tue, 12 Nov 2019 09:15:18 -0800
Message-ID: <CAPcyv4j75cQ4dSqyKGuioyyf0O9r0BG0TjFgv+w=64gLah5z6w@mail.gmail.com>
Subject: Re: DAX filesystem support on ARMv8
To: Bharat Kumar Gogada <bharatku@xilinx.com>
Message-ID-Hash: H447JEAUYWIRGF7GOXRELXKRS2UNLEV7
X-Message-ID-Hash: H447JEAUYWIRGF7GOXRELXKRS2UNLEV7
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>, "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "willy@infradead.org" <willy@infradead.org>, "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>, "jack@suse.cz" <jack@suse.cz>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/H447JEAUYWIRGF7GOXRELXKRS2UNLEV7/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Mon, Nov 11, 2019 at 6:12 PM Bharat Kumar Gogada <bharatku@xilinx.com> wrote:
>
> Hi All,
>
> As per Documentation/filesystems/dax.txt
>
> The DAX code does not work correctly on architectures which have virtually
> mapped caches such as ARM, MIPS and SPARC.
>
> Can anyone please shed light on dax filesystem issue w.r.t ARM architecture ?

The concern is VIVT caches since the kernel will want to flush pmem
addresses with different virtual addresses than what userspace is
using. As far as I know, ARMv8 has VIPT caches, so should not have an
issue. Willy initially wrote those restrictions, but I am assuming
that the concern was managing the caches in the presence of virtual
aliases.
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
