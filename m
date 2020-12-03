Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BB3532CDA4B
	for <lists+linux-nvdimm@lfdr.de>; Thu,  3 Dec 2020 16:47:25 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 676DA100ED4BA;
	Thu,  3 Dec 2020 07:47:23 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:20::242; helo=mail-lj1-x242.google.com; envelope-from=shakeelb@google.com; receiver=<UNKNOWN> 
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 0697C100ED4B7
	for <linux-nvdimm@lists.01.org>; Thu,  3 Dec 2020 07:47:21 -0800 (PST)
Received: by mail-lj1-x242.google.com with SMTP id s9so3001564ljo.11
        for <linux-nvdimm@lists.01.org>; Thu, 03 Dec 2020 07:47:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/ayfcs9PdWYm7lbPtI7skq4RBm0f2Hr2bSO79nAHtFc=;
        b=qeNyZ8YsBRIcSSEnxPslZwdaQzbHNHWQrVBr58zRszE0F8P9QlO9s+F6Eup0AC7FxW
         QCI9RwkC5r87S1DcMFuQ0LGorDW6hc5tvP0HfgHeOOAQ4yRiIDrmcnabMErr46z25doA
         KuS+R05984StHPoMfsXc6p3fX8UtHh/OTtoHz+R5rvw8+PEVFCbi/ODbvauIcTOeBy/l
         LjY8bfJMs0j0jbctFehRcbnTYB5vfU33O6FRUX3G3dJeEzqE4yjZP8cwtzrXBtIu4V9x
         qG8OhxlOwT0sXfEVrrlcH+U1SXqjVUNsoLXauBwPRBppDacfBHal0+6hTivZDoWfPiUF
         I5fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/ayfcs9PdWYm7lbPtI7skq4RBm0f2Hr2bSO79nAHtFc=;
        b=itEm8++/QzxhWWH3CEdwOV31Tc9XKgt2S3K1+CymHwMfFhIl1IV0DfEdgoTY8IFek6
         nWUD3lKlhsrllLqboAUA9CFTzc7uVx7x/cHLchB2uxnObCdeDZWlGAlRuLDYgNsEYDCf
         cGlAzcmPRDoo34CgRiE7q0Pr+JPhA37OhWH1rhYrah/qA8flD7a58UG6v0AQ3mOE90jG
         H3ox6hhoJEHCfDU/tQ4axAFHQjrYVAqAlpCW82WsiCvg4ko0zm/yF2+4yOFzYeVWEZRK
         iazO/SimCFfBvoDMqQIljW6w7Eenp8LQ0q1QnL93MktmGP4GALMamOcGNF4OOG9WNztp
         9k1w==
X-Gm-Message-State: AOAM530kPs0hwg7ZBT7e5ftTkEBBhgKkOx2UsABFWsxpR6ENffz3VPq9
	0YNBUp++iTqInC1k96lgQOQAWrffpH20zELvRhRh+w==
X-Google-Smtp-Source: ABdhPJwIWQzmwxHBiRB8EE+s5XaHTO5aY/OfRodwgESsla0us6E0o0PYvgEf52SU6B5EtE5PNDOv6vNy/ZwtEjOqjbg=
X-Received: by 2002:a2e:3c12:: with SMTP id j18mr1526064lja.192.1607010439133;
 Thu, 03 Dec 2020 07:47:19 -0800 (PST)
MIME-Version: 1.0
References: <20201203062949.5484-1-rppt@kernel.org> <20201203062949.5484-8-rppt@kernel.org>
In-Reply-To: <20201203062949.5484-8-rppt@kernel.org>
From: Shakeel Butt <shakeelb@google.com>
Date: Thu, 3 Dec 2020 07:47:07 -0800
Message-ID: <CALvZod5-r+TmuAYS7ErpSPdF0RKN_F_CbNMoXQdqONbhPxunTg@mail.gmail.com>
Subject: Re: [PATCH v14 07/10] secretmem: add memcg accounting
To: Mike Rapoport <rppt@kernel.org>
Message-ID-Hash: DFX4NEELB4KHRU2LTOCDGCWYPY4C6L7D
X-Message-ID-Hash: DFX4NEELB4KHRU2LTOCDGCWYPY4C6L7D
X-MailFrom: shakeelb@google.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Andrew Morton <akpm@linux-foundation.org>, Alexander Viro <viro@zeniv.linux.org.uk>, Andy Lutomirski <luto@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>, Catalin Marinas <catalin.marinas@arm.com>, Christopher Lameter <cl@linux.com>, Dave Hansen <dave.hansen@linux.intel.com>, David Hildenbrand <david@redhat.com>, Elena Reshetova <elena.reshetova@intel.com>, "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>, James Bottomley <jejb@linux.ibm.com>, "Kirill A. Shutemov" <kirill@shutemov.name>, Matthew Wilcox <willy@infradead.org>, Mark Rutland <mark.rutland@arm.com>, Mike Rapoport <rppt@linux.ibm.com>, Michael Kerrisk <mtk.manpages@gmail.com>, Palmer Dabbelt <palmer@dabbelt.com>, Paul Walmsley <paul.walmsley@sifive.com>, Peter Zijlstra <peterz@infradead.org>, Rick Edgecombe <rick.p.edgecombe@intel.com>, Roman Gushchin <guro@fb.com>, Shuah Khan <shuah@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Tycho Andersen <tycho@tycho.ws>, Will Deac
 on <will@kernel.org>, linux-api@vger.kernel.org, linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-fsdevel <linux-fsdevel@vger.kernel.org>, Linux MM <linux-mm@kvack.org>, LKML <linux-kernel@vger.kernel.org>, linux-kselftest@vger.kernel.org, linux-nvdimm@lists.01.org, linux-riscv@lists.infradead.org, x86@kernel.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/DFX4NEELB4KHRU2LTOCDGCWYPY4C6L7D/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Wed, Dec 2, 2020 at 10:31 PM Mike Rapoport <rppt@kernel.org> wrote:
>
> From: Mike Rapoport <rppt@linux.ibm.com>
>
> Account memory consumed by secretmem to memcg. The accounting is updated
> when the memory is actually allocated and freed.
>
> Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
> Acked-by: Roman Gushchin <guro@fb.com>

Reviewed-by: Shakeel Butt <shakeelb@google.com>
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
