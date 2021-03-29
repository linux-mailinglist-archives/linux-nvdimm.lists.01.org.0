Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6089834CCF3
	for <lists+linux-nvdimm@lfdr.de>; Mon, 29 Mar 2021 11:24:09 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id DE27A100EBBB9;
	Mon, 29 Mar 2021 02:24:06 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=sbhat@linux.ibm.com; receiver=<UNKNOWN> 
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 9F98A100EBBB3
	for <linux-nvdimm@lists.01.org>; Mon, 29 Mar 2021 02:24:04 -0700 (PDT)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 12T948ek069464;
	Mon, 29 Mar 2021 05:23:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : subject : to : cc
 : references : message-id : date : mime-version : in-reply-to :
 content-type; s=pp1; bh=KtR2gtZBTXynmFoaIQUPB36jR2X+bDje79BXt0/UUWw=;
 b=b8w3T3KWNheWIZh4niYFTydZOLvibUPD0IMZO521FmxkzMCXNE7D0xIpE24LREg9cYe2
 sIdbPYL3H9+0ZwOQI+9JYEMyku/SxcfkBUKfHVgHlYPYRK/6K2vyaOYGEafAhXz3WQIN
 fcr31FBMzlaeYKUGLQachGpFZWmcmktMRs/Dg7YmgG1jHUMrZDypIJkOUfT3nNqz8cg0
 KPDVBUcPZMaw3AzuVmAwKWaiT3sKEfyKUxcvBfnXMONlLjsvOvm8urqLBq364NuicBZa
 Kf+GMYHa5kbzok1YGQpqiA6KNMKuo13c/7wuJiVpIgVhukK0eXVh4z2xWL67qNmsixBc Jg==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com with ESMTP id 37jj98s60r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 29 Mar 2021 05:23:56 -0400
Received: from m0098417.ppops.net (m0098417.ppops.net [127.0.0.1])
	by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 12T96E8Y078138;
	Mon, 29 Mar 2021 05:23:56 -0400
Received: from ppma02fra.de.ibm.com (47.49.7a9f.ip4.static.sl-reverse.com [159.122.73.71])
	by mx0a-001b2d01.pphosted.com with ESMTP id 37jj98s5yy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 29 Mar 2021 05:23:55 -0400
Received: from pps.filterd (ppma02fra.de.ibm.com [127.0.0.1])
	by ppma02fra.de.ibm.com (8.16.0.43/8.16.0.43) with SMTP id 12T9DVnh022350;
	Mon, 29 Mar 2021 09:23:53 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
	by ppma02fra.de.ibm.com with ESMTP id 37hvb88v71-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 29 Mar 2021 09:23:53 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
	by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 12T9Np5l41812284
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 29 Mar 2021 09:23:51 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 69AEA52050;
	Mon, 29 Mar 2021 09:23:51 +0000 (GMT)
Received: from [9.77.196.188] (unknown [9.77.196.188])
	by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 4A32D52054;
	Mon, 29 Mar 2021 09:23:48 +0000 (GMT)
From: Shivaprasad G Bhat <sbhat@linux.ibm.com>
Subject: Re: [PATCH v3 2/3] spapr: nvdimm: Implement H_SCM_FLUSH hcall
To: David Gibson <david@gibson.dropbear.id.au>
References: <161650723087.2959.8703728357980727008.stgit@6532096d84d3>
 <161650725183.2959.12071056430236337803.stgit@6532096d84d3>
 <YFqs8M1dHAFhdCL6@yekko.fritz.box>
Message-ID: <13744465-ca7a-0aaf-5abb-43a70a39c167@linux.ibm.com>
Date: Mon, 29 Mar 2021 14:53:47 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <YFqs8M1dHAFhdCL6@yekko.fritz.box>
Content-Language: en-US
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: iiRzvzgBGYE802w29iw-3XBvPv0QF6wC
X-Proofpoint-ORIG-GUID: JxrHrep7tjmAYwbA_6UUN4owRKHr0f_w
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-03-29_04:2021-03-26,2021-03-29 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 clxscore=1015
 adultscore=0 impostorscore=0 suspectscore=0 lowpriorityscore=0
 priorityscore=1501 mlxscore=0 malwarescore=0 phishscore=0 spamscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2103250000 definitions=main-2103290071
Message-ID-Hash: XIE66AJ3SUEON2CXRWOMMMUCFHKKMKO7
X-Message-ID-Hash: XIE66AJ3SUEON2CXRWOMMMUCFHKKMKO7
X-MailFrom: sbhat@linux.ibm.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
X-Content-Filtered-By: Mailman/MimeDel 3.1.1
CC: sbhat@linux.vnet.ibm.com, groug@kaod.org, qemu-ppc@nongnu.org, ehabkost@redhat.com, marcel.apfelbaum@gmail.com, mst@redhat.com, imammedo@redhat.com, xiaoguangrong.eric@gmail.com, qemu-devel@nongnu.org, aneesh.kumar@linux.ibm.com, linux-nvdimm@lists.01.org, kvm-ppc@vger.kernel.org, shivaprasadbhat@gmail.com, bharata@linux.vnet.ibm.com
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/XIE66AJ3SUEON2CXRWOMMMUCFHKKMKO7/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
Content-Transfer-Encoding: 7bit


On 3/24/21 8:37 AM, David Gibson wrote:
> On Tue, Mar 23, 2021 at 09:47:38AM -0400, Shivaprasad G Bhat wrote:
>> machine vmstate.
>>
>> Signed-off-by: Shivaprasad G Bhat<sbhat@linux.ibm.com>
> An overal question: surely the same issue must arise on x86 with
> file-backed NVDIMMs.  How do they handle this case?

Discussed in other threads..

....

>>   };
>> @@ -2997,6 +3000,9 @@ static void spapr_machine_init(MachineState *machine)
>>       }
>>   
>>       qemu_cond_init(&spapr->fwnmi_machine_check_interlock_cond);
>> +    qemu_mutex_init(&spapr->spapr_nvdimm_flush_states_lock);
> Do you actually need an extra mutex, or can you rely on the BQL?

I verified BQL is held at all places where it matters in the context of 
this patch.

Safe to get rid of this extra mutex.

...

>
>> +{
>> +     SpaprMachineState *spapr = SPAPR_MACHINE(qdev_get_machine());
>> +
>> +     return (!QLIST_EMPTY(&spapr->pending_flush_states) ||
>> +             !QLIST_EMPTY(&spapr->completed_flush_states));
>> +}
>> +
>> +static int spapr_nvdimm_pre_save(void *opaque)
>> +{
>> +    SpaprMachineState *spapr = SPAPR_MACHINE(qdev_get_machine());
>> +
>> +    while (!QLIST_EMPTY(&spapr->pending_flush_states)) {
>> +        aio_poll(qemu_get_aio_context(), true);
> Hmm... how long could waiting for all the pending flushes to complete
> take?  This could add substanially to the guest's migration downtime,
> couldn't it?


The time taken depends on the number of dirtied pages and the disk io 
write speed. The number of dirty pages on host is configureable with 
tunables vm.dirty_background_ratio (10% default on Fedora 32, Ubuntu 
20.04), vm.dirty_ratio(20%) of host memory and|or 
vm.dirty_expire_centisecs(30 seconds). So, the host itself would be 
flushing the mmaped file on its own from time to time. For guests using 
the nvdimms with filesystem, the flushes would have come frequently and 
the number of dirty pages might be less. The pmem applications can use 
the nvdimms without a filesystem. And for such guests, the chances that 
a flush request can come from pmem applications at the time of migration 
is less or is random. But, the host would have flushed the pagecache on 
its own when vm.dirty_background_ratio is crossed or 
vm.dirty_expire_centisecs expired. So, the worst case would stands at 
disk io latency for writing the dirtied pages in the last 
vm.dirty_expire_centisecs on host OR latency for writing maximum 
vm.dirty_background_ratio(10%) of host RAM. If you want me to calibrate 
any particular size, scenario and get the numbers please let me know.

...
>> +
>> +/*
>> + * Acquire a unique token and reserve it for the new flush state.
>> + */
>> +static SpaprNVDIMMDeviceFlushState *spapr_nvdimm_init_new_flush_state(void)
>> +{
>> +    Error *err = NULL;
>> +    uint64_t token;
>> +    SpaprMachineState *spapr = SPAPR_MACHINE(qdev_get_machine());
>> +    SpaprNVDIMMDeviceFlushState *tmp, *next, *state;
>> +
>> +    state = g_malloc0(sizeof(*state));
>> +
>> +    qemu_mutex_lock(&spapr->spapr_nvdimm_flush_states_lock);
>> +retry:
>> +    if (qemu_guest_getrandom(&token, sizeof(token), &err) < 0) {
> Using getrandom seems like overkill, why not just use a counter?

I didnt want a spurious guest to abuse by consuming the return value 
providing

a valid "guess-able" counter and the real driver failing subsequently. 
Also, across

guest migrations carrying the global counter to destination is another 
thing to ponder.


Let me know if you want me to reconsider using counter.

...

>> mm_flush_states_lock);
>> +
>> +    return state;
>> +}
>> +
>> +/*
>> + * spapr_nvdimm_finish_flushes
>> + *      Waits for all pending flush requests to complete
>> + *      their execution and free the states
>> + */
>> +void spapr_nvdimm_finish_flushes(void)
>> +{
>> +    SpaprNVDIMMDeviceFlushState *state, *next;
>> +    SpaprMachineState *spapr = SPAPR_MACHINE(qdev_get_machine());
> The caller has natural access to the machine, so pass it in rather
> than using the global.

okay

...

>> +
>> +/*
>> + * spapr_nvdimm_get_hcall_status
>> + *      Fetches the status of the hcall worker and returns H_BUSY
>> + *      if the worker is still running.
>> + */
>> +static int spapr_nvdimm_get_flush_status(uint64_t token)
>> +{
>> +    int ret = H_LONG_BUSY_ORDER_10_MSEC;
>> +    SpaprMachineState *spapr = SPAPR_MACHINE(qdev_get_machine());
> The callers have natural access to spapr, so pass it in rather than
> using the global.

Okay

...

>> +
>> +/*
>> + * H_SCM_FLUSH
>> + * Input: drc_index, continue-token
>> + * Out: continue-token
>> + * Return Value: H_SUCCESS, H_Parameter, H_P2, H_BUSY
>> + *
>> + * Given a DRC Index Flush the data to backend NVDIMM device.
>> + * The hcall returns H_BUSY when the flush takes longer time and the hcall
> It returns one of the H_LONG_BUSY values, not actual H_BUSY, doesn't
> it?

Yes. I thought its okay to call it just H_BUSY in a generic way. Will 
fix it.


>> + * needs to be issued multiple times in order to be completely serviced.
>> +        }
>> +
>> +        return ret;
>> +    }
>> +
>> +    dimm = PC_DIMM(drc->dev);
>> +    backend = MEMORY_BACKEND(dimm->hostmem);
>> +
>> +    state = spapr_nvdimm_init_new_flush_state();
>> +    if (!state) {
>> +        return H_P2;
> AFAICT the only way init_new_flush_state() fails is a failure in the
> RNG, which definitely isn't a parameter problem.

Will change it to H_HARDWARE.


>> +    }
>> +
>> +    state->backend_fd = memory_region_get_fd(&backend->mr);
> Is this guaranteed to return a usable fd in all configurations?

Right, for memory-backend-ram this wont work. I think we should

not set the hcall-flush-required too for memory-backend-ram. Will fix this.

>> +    thread_pool_submit_aio(pool, flush_worker_cb, state,
>> +                           spapr_nvdimm_flush_completion_cb, state);
>> +
>> +    ret = spapr_nvdimm_get_flush_status(state->continue_token);
>> +    if (H_IS_LONG_BUSY(ret)) {
>> +        args[0] = state->continue_token;
>> +    }
>> +
>> +    return ret;
> I believe you can rearrange this so the get_flush_status / check /
> return is shared between the args[0] == 0 and args[0] == token paths.
okay.

Thanks,

Shiva

_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
