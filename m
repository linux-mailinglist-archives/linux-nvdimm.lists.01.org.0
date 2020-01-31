Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E96DC14E6BB
	for <lists+linux-nvdimm@lfdr.de>; Fri, 31 Jan 2020 01:51:04 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id D9F4510FC3167;
	Thu, 30 Jan 2020 16:54:20 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::244; helo=mail-oi1-x244.google.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mail-oi1-x244.google.com (mail-oi1-x244.google.com [IPv6:2607:f8b0:4864:20::244])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 00E6310FC3162
	for <linux-nvdimm@lists.01.org>; Thu, 30 Jan 2020 16:54:17 -0800 (PST)
Received: by mail-oi1-x244.google.com with SMTP id q84so5642628oic.4
        for <linux-nvdimm@lists.01.org>; Thu, 30 Jan 2020 16:51:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6EgYI4BzZC357sxK5sBeEwltAOQEx/wkQQe+cPdH4pw=;
        b=w+Mcx2UxiC8eZVh56Y/8Rj/FnTtbPUT7vM3h1c7JvpyOv6PJn2h8IrsfjN1Vmgubss
         546P5Z//g9XKExdbJYLid275VCZUKUNFwD6FogfVmStT5NJpfGcms2XMogN5kqTl9J3T
         YzYb/QQMw/g5kGIElGUeIWm3uGFx45IYFCIJ2EHz27gADCKzrCFHVneUiuWyf+7qVbhU
         YAoQRLxaGOhwEBCKjV0VrPFOJppWbYHfWiyFPPmXfd8jg6nGudpjYOzR50fHF9vVc8N8
         WUiCeqUT4gav8IaLtWEo+zinRQVfcL5ZBShjtyzmw8ootRpwUEf6eCNv09UFMV6Ulll4
         RKhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6EgYI4BzZC357sxK5sBeEwltAOQEx/wkQQe+cPdH4pw=;
        b=dS8wdoTVDZ+uiAD2AAScvin4qsF4OdHQUOJjjIHN+CP1vmrQMLY/mw5FMZKAJMDIRy
         TBgjYmiTAxtoGjtfBvCQBfsjj8h8hSwnphcD9PbLKFYoXElXzVFtpE747VtFyv/OeCEj
         N6vSQwsGZs20Vl5Y3RjjdsQNwKhvndxgw8kJs9Nb6yeczB4fwy6V/uFqN8Px2hlim9aB
         IaaHOShFCE9kisZZERteRBtBA3Nc9cM8XfXugmjyuu/X9BfSH5LkTsqfp/rb4ifrq2NC
         o28LTP8CINMUlVcNrYoPq5Pl8sPu/mVTJ5GjVYQ2couEnaUhehhI3q82kHhPakfqLBij
         BefA==
X-Gm-Message-State: APjAAAWjJGmTOjTFpxW502h1pDzscLjlQpU5PgJoPCfz6H9E4ZiwzrjX
	iF5NCu0uK1khPT+pFMg0HbAtWqfyVyiYSPGyVELbgA==
X-Google-Smtp-Source: APXvYqybvPV+j2Fa15gFBK6YCW50krygkSAX1zBKKZYLrGFttO+cpg8GsSYgkNPRZ8UGNIwMZmQcn50+8nOxuB0fj7E=
X-Received: by 2002:aca:4c9:: with SMTP id 192mr4916521oie.105.1580431859037;
 Thu, 30 Jan 2020 16:50:59 -0800 (PST)
MIME-Version: 1.0
References: <20200131004023.31255-1-vishal.l.verma@intel.com>
In-Reply-To: <20200131004023.31255-1-vishal.l.verma@intel.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Thu, 30 Jan 2020 16:50:48 -0800
Message-ID: <CAPcyv4h2du0iouG=huomy0THtBhJ_ub7GBRd2e19rTusBj6tdw@mail.gmail.com>
Subject: Re: [ndctl PATCH v2] ndctl/lib: fix symbol redefinitions reported by GCC10
To: Vishal Verma <vishal.l.verma@intel.com>
Message-ID-Hash: U5GEJY2I3AB5UOX4K6UQYIATZBF4ZVL2
X-Message-ID-Hash: U5GEJY2I3AB5UOX4K6UQYIATZBF4ZVL2
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: linux-nvdimm <linux-nvdimm@lists.01.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/U5GEJY2I3AB5UOX4K6UQYIATZBF4ZVL2/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Thu, Jan 30, 2020 at 4:40 PM Vishal Verma <vishal.l.verma@intel.com> wrote:
>
> A toolchain update in Fedora 32 caused new compile errors due to
> multiple definitions of dimm_ops structures. The declarations in
> 'private.h' for the various NFIT families are present so that libndctl
> can find all the per-family dimm-ops. However they need to be declared
> as extern because the actual definitions are in <family>.c.
> Additionally, 'param' instances in list.c and monitor.c need to be
> marked as static.
>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Suggested-by: Dan Williams <dan.j.williams@intel.com>

Reviewed-by: Dan Williams <dan.j.williams@intel.com>
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
