Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9029111904E
	for <lists+linux-nvdimm@lfdr.de>; Tue, 10 Dec 2019 20:06:12 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 84FA810113615;
	Tue, 10 Dec 2019 11:09:33 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::243; helo=mail-oi1-x243.google.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mail-oi1-x243.google.com (mail-oi1-x243.google.com [IPv6:2607:f8b0:4864:20::243])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 02B2910113615
	for <linux-nvdimm@lists.01.org>; Tue, 10 Dec 2019 11:09:30 -0800 (PST)
Received: by mail-oi1-x243.google.com with SMTP id x195so10866768oix.4
        for <linux-nvdimm@lists.01.org>; Tue, 10 Dec 2019 11:06:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lm0qjFt/+snyw9l0OjmW9SiqN5sT07oRcQlj3rvkvyQ=;
        b=INyp8HriDUzc6C/ZyER7ejVcLfuU+5HybZtskbfdrf5sVq4Qz/6b2u3owxRoh+CF+N
         1jFHxPt4rkfIv28oxNJR2Pwl8brRThcUGeXIBDXn8iEXLW44r7q+EASvWYVe0kbyuYxF
         I/eIrOLNuThTDZ/lmcBx2aTVzLRRWOtUEc3X4XNs+vnLsmmaSlk/gnHi9QxkKNe99Jrf
         mpAD7abJ/5wwsJqv/qu8O1mjZgXZvO8OXTj1CMvWl2AIY8gQ9XWHNZQyH7KUPSLM9kxZ
         qSvp9Z1HxefklcC6CGbeLjtpsMzvBLO4ZdiPcwXWxMUGQHBA4aIlYiUyKDej+rBz2pzo
         XhLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lm0qjFt/+snyw9l0OjmW9SiqN5sT07oRcQlj3rvkvyQ=;
        b=IHfKM8A4/C+/AqlXmm9v5ZP9bfW1myQG4t3S1O7NbE4TNC+j1IfkFMBLb1CHSzFitY
         d99/0TXEnOovVR/C5bpo3dLHxn2cKD3JIIpXmXeh0JdBQNqkk0sLl0G8tAOWqDkbJoFj
         y/PFuxqS4/6alTDqWBwDFG+GqqyYbNgCh1nN2ZtNczqz9kqBmLETpkdmIIinCaYoJOh1
         Gl8JVwJ12lkkUrRwFWeZ75W3wDARUtTaChjxT69ysg4RS5Scpbe4/HBTiw3jitWAihy7
         vuPXD0bLjwuB+NeMGRaxozapzZIy7ftFsTth4Mvc2pEcEqEnck4/VhOOPU8N3ta0ZhC5
         8KjQ==
X-Gm-Message-State: APjAAAVe0GF5OmxHl1BvppOOw0HSUvjsO6zbaKOpSfXiTfDLuuUcQ+7K
	nWQhAs8o4ncp1ufCFnmvyCBGR11VWcMijabEuCevTvUS
X-Google-Smtp-Source: APXvYqz9iJj9T4qBIF5fi0fFAFynevtBEGcI+0LmNyYp1Pm4Gakpx+JcR2yusr2mH9LsSVxtvZSn/dtDxA/ACldX6w4=
X-Received: by 2002:a05:6808:a83:: with SMTP id q3mr384365oij.0.1576004768043;
 Tue, 10 Dec 2019 11:06:08 -0800 (PST)
MIME-Version: 1.0
References: <20191206064731.283172-1-santosh@fossix.org>
In-Reply-To: <20191206064731.283172-1-santosh@fossix.org>
From: Dan Williams <dan.j.williams@intel.com>
Date: Tue, 10 Dec 2019 11:05:56 -0800
Message-ID: <CAPcyv4jTpNmc2Bvs0ivdD1VpXPvJT=ZjaB+c7L2i7JaQp6QgBQ@mail.gmail.com>
Subject: Re: [PATCH] ndctl/zero-labels: Display error if regions are active
To: Santosh Sivaraj <santosh@fossix.org>
Message-ID-Hash: GBQN2K3F76A2H3YPNN7SEH654AXVE4FS
X-Message-ID-Hash: GBQN2K3F76A2H3YPNN7SEH654AXVE4FS
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: linux-nvdimm <linux-nvdimm@lists.01.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/GBQN2K3F76A2H3YPNN7SEH654AXVE4FS/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Thu, Dec 5, 2019 at 10:48 PM Santosh Sivaraj <santosh@fossix.org> wrote:
>
> Get zero-labels behave similar to init-labels.

This changelog could be more precise. I'll fix this up to be.

"Make zero-labels behave the same as init-labels with respect to
failing the operation while the DIMM is active (i.e. label area is
busy)."

>
> Signed-off-by: Santosh Sivaraj <santosh@fossix.org>

...otherwise, looks good, applied.
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
