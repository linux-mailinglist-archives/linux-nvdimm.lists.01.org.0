Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 412E075D3C
	for <lists+linux-nvdimm@lfdr.de>; Fri, 26 Jul 2019 04:56:40 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id AD2CA212E13D3;
	Thu, 25 Jul 2019 19:59:05 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::341; helo=mail-ot1-x341.google.com;
 envelope-from=dan.j.williams@intel.com; receiver=linux-nvdimm@lists.01.org 
Received: from mail-ot1-x341.google.com (mail-ot1-x341.google.com
 [IPv6:2607:f8b0:4864:20::341])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id 753A9212E13CA
 for <linux-nvdimm@lists.01.org>; Thu, 25 Jul 2019 19:59:03 -0700 (PDT)
Received: by mail-ot1-x341.google.com with SMTP id x21so15442593otq.12
 for <linux-nvdimm@lists.01.org>; Thu, 25 Jul 2019 19:56:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=intel-com.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=jtsRFEqsbhDF5GHkB0BWff2HeL6bhrncE57oB+lpI6g=;
 b=bO1q6L/Cb+rqvJcYJcMdzeOFi9YEcoAD3a4Kk3/9XD6WnLQx/0DuvOsph8rSekU8/P
 IkO7dsR655hA/drVIGH/as6yyR//szlEGqPtFddLTtldtmBJbAXDEXSu82yeJqSSumTV
 M5SgKpUXXNQKYwlK6V2VeZq4qkQUVPC119bt1hVMMKYrwIxy1S849Ka3jZPmK/bEnsCZ
 aYaJsbjlNme80vHmzZzzr0aHlDQpJci//jpS6hNEWfKybFXeViczsU0iQ2PZNEbAzhfw
 6ueJ75MDRCzJI3bVpgl8EllOc2PjuRTP0JJezpYoX3jAndM+gFjeSk80E0oGEKPHPaMR
 hF1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=jtsRFEqsbhDF5GHkB0BWff2HeL6bhrncE57oB+lpI6g=;
 b=onpU3TRKfEBxJV4D9pd8IMVadn++uWZWUT8bmHmnQzP19W/GWjSYoypQw0BMC+cNMl
 EAo/nfryKsclYxvwjz++gbqvvSf2H6VWeXpmvhqXL3hE5Wrut4e/IAnr+g7e8mU/Vduf
 qGHbInIXEd3SlUz8JgNr3vP2rqaUO08PKnNLweJjaFDScf/wv8JKHsea4fyBt+8uoFuv
 Qp3SY6DZmBkRlSPYB0g+EuA9dNC6TbMdGUl5gpAO5wMBUpheJgLFZ26wfpx32+uwOOzF
 Ocfyf068+EMCS9aT///EIytyEPLKgQxgezgfTjqHYs7MDdQm/jwQ8Ob6Kja+7/U2Ga5x
 3/4A==
X-Gm-Message-State: APjAAAVaFg9tfl4lrbTmT/Eh5p6Nq5cNe4e/FhjPtiaeTjZ2DMj0kAbL
 NEkTvopYhHDTYm8IbxzYNXhGIXZIaqZHRgB5MXzLEQ==
X-Google-Smtp-Source: APXvYqwKpyJIfoEV872dAb3ITlGvduy3aqYWDDKZ87OlK/bdnRwN6mLeR5MFfOjMYGBgBu3Y+YrusMm4C8wX7HHG4J0=
X-Received: by 2002:a9d:7a9a:: with SMTP id l26mr61967792otn.71.1564109796107; 
 Thu, 25 Jul 2019 19:56:36 -0700 (PDT)
MIME-Version: 1.0
References: <20190724215741.18556-1-vishal.l.verma@intel.com>
 <20190724215741.18556-13-vishal.l.verma@intel.com>
In-Reply-To: <20190724215741.18556-13-vishal.l.verma@intel.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Thu, 25 Jul 2019 19:56:25 -0700
Message-ID: <CAPcyv4jaN0ZbROkOifugpd381WhxYJhC-axWyjwN_9s8dDez8w@mail.gmail.com>
Subject: Re: [ndctl PATCH v7 12/13] contrib/ndctl: add bash-completion for the
 new daxctl commands
To: Vishal Verma <vishal.l.verma@intel.com>
X-BeenThere: linux-nvdimm@lists.01.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
List-Unsubscribe: <https://lists.01.org/mailman/options/linux-nvdimm>,
 <mailto:linux-nvdimm-request@lists.01.org?subject=unsubscribe>
List-Archive: <http://lists.01.org/pipermail/linux-nvdimm/>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Subscribe: <https://lists.01.org/mailman/listinfo/linux-nvdimm>,
 <mailto:linux-nvdimm-request@lists.01.org?subject=subscribe>
Cc: Dave Hansen <dave.hansen@linux.intel.com>,
 Pavel Tatashin <pasha.tatashin@soleen.com>,
 linux-nvdimm <linux-nvdimm@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

On Wed, Jul 24, 2019 at 2:58 PM Vishal Verma <vishal.l.verma@intel.com> wrote:
>
> Add bash completion helpers for the new daxctl-reconfigure-device,
> daxctl-online-memory, and daxctl-offline-memory commands.
>

Looks good,

Reviewed-by: Dan Williams <dan.j.williams@intel.com>
_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
